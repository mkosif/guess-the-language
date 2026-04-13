import { Question } from '../model/Question';
import { cryptoFramework } from '@kit.CryptoArchitectureKit';

//Fisher-Yates Shuffle Algorithm
export function shuffleList(questionList: Question[]) {
  for (let i = 0; i < questionList.length; i++) {
    try {
      let rand = cryptoFramework.createRandom();
      let randOutput = rand.generateRandomSync(1);
      let randomIndex = i + Math.floor(randOutput.data[0] * (questionList.length - i) / 256)
      console.info(`new random is ${randomIndex}-`)
      const tmp = questionList[randomIndex];
      questionList[randomIndex] = questionList[i]
      questionList[i] = tmp
    } catch (error) {
      console.error(`Shuffle error at index ${i}: ${error}`);
    }
  }
}
