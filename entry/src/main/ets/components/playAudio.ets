import media from '@ohos.multimedia.media';
import audio from '@ohos.multimedia.audio';
import { BusinessError } from '@kit.BasicServicesKit';

export async function playAudio(filePath: string, context: Context) {
  const player: media.AVPlayer | undefined = await media.createAVPlayer();
  let audioStreamInfo1: audio.AudioStreamInfo = {
    samplingRate: audio.AudioSamplingRate.SAMPLE_RATE_44100,
    channels: audio.AudioChannel.CHANNEL_1,
    sampleFormat: audio.AudioSampleFormat.SAMPLE_FORMAT_S16LE,
    encodingType: audio.AudioEncodingType.ENCODING_TYPE_RAW
  };
  let audioRendererInfo: audio.AudioRendererInfo = {
    usage: audio.StreamUsage.STREAM_USAGE_VOICE_COMMUNICATION,
    rendererFlags: 0
  };
  let audioRendererOptions: audio.AudioRendererOptions = {
    streamInfo: audioStreamInfo1,
    rendererInfo: audioRendererInfo
  };

  audio.createAudioRenderer(audioRendererOptions, (err, audioRenderer: audio.AudioRenderer) => {
    if (err) {
      console.error(`AudioRenderer Created: Error: ${err}`);
    } else {
      audioRenderer.on('audioInterrupt', (interruptEvent: audio.InterruptEvent) => {
        console.info('Succeeded');
      });
      audioRenderer.on('outputDeviceChangeWithInfo', () => {
        console.error(`createAudioRenderer outputDeviceChangeWithInfo`);
      })
      console.info('AudioRenderer Created: Success: SUCCESS');
    }
  });

  const file = await context.resourceManager.getRawFd(filePath);
  const avFileDesc: media.AVFileDescriptor = {
    fd: file.fd, offset: file.offset, length: file.length
  }


  if (!player) {
    return;
  }
  player.fdSrc = avFileDesc;
  setAVPlayerCallback(player)


  await player.prepare();
  console.info('Audio interrupt: Prepared');
  player.on('audioInterrupt', (info) => {
    switch (info.hintType) {
      case audio.InterruptHint.INTERRUPT_HINT_PAUSE:
        console.info('Audio interrupt: PAUSE');
        break;
      case audio.InterruptHint.INTERRUPT_HINT_STOP:
        console.info('Audio interrupt: STOP');
        break;
      case audio.InterruptHint.INTERRUPT_HINT_DUCK:
        console.info('Audio interrupt: DUCK');
        break;
      case audio.InterruptHint.INTERRUPT_HINT_UNDUCK:
        console.info('Audio interrupt: UNDUCK');
        break;
      case audio.InterruptHint.INTERRUPT_HINT_RESUME:
        console.info('Audio interrupt: RESUME');
        player.play()
        break;
    }
  });
  player.play();
}

function setAVPlayerCallback(avPlayer: media.AVPlayer) {

  avPlayer.on('error', (err: BusinessError) => {
    avPlayer.reset();
  });

  avPlayer.on('stateChange', async (state: string, reason: media.StateChangeReason) => {
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
      case 'playing':
        break;
      case 'paused':
        break;
      case 'completed':
        avPlayer.stop();
        break;
      case 'stopped':
        avPlayer.reset();
        break;
      case 'released':
        break;
      default:
        break;
    }
  });
}

function createPlay(): Promise<media.AVPlayer> {
  return new Promise((resolve, reject) => {
    media.createAVPlayer((error: BusinessError, player) => {
      if (player) {
        player.on('audioInterrupt', (interruptEvent: audio.InterruptEvent) => {
          console.info('Succeeded');
        });
        player.on('audioOutputDeviceChangeWithInfo', () => {
          console.error(`createAVPlayer audioOutputDeviceChangeWithInfo`);
        });
        console.info('Succeeded in creating AVPlayer.');
        resolve(player)
      } else {
        console.error(`Failed to create AVPlayer, error message:${error.message}`);
      }
    });
  }
  )
}