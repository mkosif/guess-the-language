import { Question } from '../model/Question';
import { util } from '@kit.ArkTS';
import { shuffleList } from './ShuffleList';

// Typed interface matching the shape of questions.json
interface QuestionsFile {
  Asia: Question[];
  Europe: Question[];
  Africa: Question[];
  America: Question[];
}

/**
 * Loads and returns a shuffled question list for the given continent from
 * rawfile/questions.json. Pass 'All' to combine all continents.
 */
export function loadContinentQuestions(context: Context, continent: string): Question[] {
  try {
    const raw: Uint8Array = context.resourceManager.getRawFileContentSync('questions.json');
    const decoder = new util.TextDecoder('utf-8');
    const text: string = decoder.decode(raw);
    const data = JSON.parse(text) as QuestionsFile;

    const continentMap: Record<string, Question[]> = {
      'Asia': data.Asia ?? [],
      'Europe': data.Europe ?? [],
      'Africa': data.Africa ?? [],
      'America': data.America ?? []
    };

    let list: Question[];
    if (continent === 'All') {
      list = [
        ...(continentMap['Asia']),
        ...(continentMap['Europe']),
        ...(continentMap['Africa']),
        ...(continentMap['America'])
      ];
    } else {
      list = continentMap[continent] ?? [];
    }

    shuffleList(list);
    return list;
  } catch (e) {
    console.error(`QuestionLoader: failed to load "${continent}": ${e}`);
    return [];
  }
}
