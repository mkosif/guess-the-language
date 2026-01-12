import { Question } from '../model/Question';
import { cryptoFramework } from '@kit.CryptoArchitectureKit';

//Fisher-Yates Shuffle Algorithm
export function shuffleList(questionList: Question[]) {
  for (let i = 0; i < questionList.length; i++) {
    let rand = cryptoFramework.createRandom();
    let randOutput = rand.generateRandomSync(1);
    let mappedRandom = Math.floor((randOutput.data[0] - 1) * (questionList.length) / (255))
    console.info(`new random is ${mappedRandom}-`)
    const tmp = questionList[mappedRandom];
    questionList[mappedRandom] = questionList[i]
    questionList[i] = tmp
  }
}