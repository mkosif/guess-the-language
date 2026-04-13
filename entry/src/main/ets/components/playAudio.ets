import media from '@ohos.multimedia.media';
import audio from '@ohos.multimedia.audio';
import { BusinessError } from '@kit.BasicServicesKit';

export async function playAudio(filePath: string, context: Context) {
  try {
    const player: media.AVPlayer = await media.createAVPlayer();

    setAVPlayerCallback(player);

    const file = await context.resourceManager.getRawFd(filePath);
    player.fdSrc = {
      fd: file.fd,
      offset: file.offset,
      length: file.length
    };
  } catch (error) {
    console.error(`playAudio failed for ${filePath}: ${error}`);
  }
}

function setAVPlayerCallback(avPlayer: media.AVPlayer) {
  avPlayer.on('error', (err: BusinessError) => {
    try {
      avPlayer.reset();
    } catch (error) {
      console.error(`AVPlayer reset failed: ${error}`);
    }
  });

  avPlayer.on('stateChange', async (state: string, reason: media.StateChangeReason) => {
    try {
      switch (state) {
        case 'idle':
          avPlayer.release();
          break;
        case 'initialized':
          avPlayer.audioRendererInfo = {
            usage: audio.StreamUsage.STREAM_USAGE_MUSIC,
            rendererFlags: 0
          };
          avPlayer.prepare();
          break;
        case 'prepared':
          avPlayer.play();
          break;
        case 'completed':
          avPlayer.stop();
          break;
        case 'stopped':
          avPlayer.reset();
          break;
        default:
          break;
      }
    } catch (error) {
      console.error(`AVPlayer stateChange error in state ${state}: ${error}`);
    }
  });
}
