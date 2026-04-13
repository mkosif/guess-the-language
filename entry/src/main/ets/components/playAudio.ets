import media from '@ohos.multimedia.media';
import audio from '@ohos.multimedia.audio';
import { BusinessError } from '@kit.BasicServicesKit';

const audioFileCache: Map<string, media.AVFileDescriptor> = new Map();

async function getAudioDescriptor(filePath: string, context: Context): Promise<media.AVFileDescriptor> {
  const cached = audioFileCache.get(filePath);
  if (cached) {
    return cached;
  }

  try {
    const file = await context.resourceManager.getRawFd(filePath);
    const descriptor: media.AVFileDescriptor = {
      fd: file.fd,
      offset: file.offset,
      length: file.length
    };
    audioFileCache.set(filePath, descriptor);
    return descriptor;
  } catch (error) {
    console.error(`getAudioDescriptor failed for ${filePath}: ${error}`);
    throw new Error(`Failed to load audio descriptor for ${filePath}`);
  }
}

export async function preloadAudioFiles(context: Context, filePaths: string[]): Promise<void> {
  await Promise.all(filePaths.map(async (filePath: string) => {
    try {
      await getAudioDescriptor(filePath, context);
    } catch (error) {
      console.error(`preloadAudioFiles failed for ${filePath}: ${error}`);
    }
  }));
}

export async function playAudio(filePath: string, context: Context) {
  try {
    const player: media.AVPlayer = await media.createAVPlayer();
    let released = false;

    const releasePlayer = async () => {
      if (released) {
        return;
      }
      released = true;
      try {
        await player.release();
      } catch (error) {
        console.error(`AVPlayer release failed: ${error}`);
      }
    };

    player.on('error', async (err: BusinessError) => {
      console.error(`AVPlayer error for ${filePath}: ${err}`);
      await releasePlayer();
    });

    player.on('stateChange', async (state: string) => {
      if (state === 'completed' || state === 'stopped') {
        await releasePlayer();
      }
    });

    player.audioRendererInfo = {
      usage: audio.StreamUsage.STREAM_USAGE_MUSIC,
      rendererFlags: 0
    };
    player.fdSrc = await getAudioDescriptor(filePath, context);
    await player.prepare();
    player.play();
  } catch (error) {
    console.error(`playAudio failed for ${filePath}: ${error}`);
  }
}
