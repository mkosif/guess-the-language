import { Question } from '../model/Question';
import {asiaList, europeList} from '../viewmodel/Questions2'
import {shuffleList} from '../utils/ShuffleList'

export class Questions {
  private unitMap: Map<string, () => []>;

  constructor() {
    this.unitMap = new Map<string, () => []>();
    this.unitMap.set('All', this.allList.bind(this));
    this.unitMap.set('Asia', asiaList.bind(this));
    this.unitMap.set('Europe', europeList.bind(this));
    this.unitMap.set('Africa', this.africaList.bind(this));
    this.unitMap.set('America', this.americaList.bind(this));
  }

  callMethodByName(methodName: string): Question[] {
    const methodFunc = this.unitMap.get(methodName);
    if (methodFunc) {
      return methodFunc();
    }
    return [];
  }

  allList(): Question[] {
    const allList: Question[] = [...asiaList(), ...europeList(), ...this.africaList(), ...this.americaList()]
    shuffleList(allList)
    return allList;
  }

  africaList(): Question[] {
    const questionList: Question[] = [
      {
        question: 'سوف تمطر غداً', //It will rain tomorrow.
        languageException : false,
        options: [
          {
            value: 'Arabic',
            isCorrect: true
          },
          {
            value: 'Somali',
            isCorrect: false
          },
          {
            value: 'Hebrew',
            isCorrect: false
          },
          {
            value: 'Vietnamese',
            isCorrect: false
          }
        ]
      },
      {
        question: 'Mbi yeke na retart na kua', //I'm late for work
        languageException : false,
        options: [
          {
            value: 'Malagasy',
            isCorrect: false
          },
          {
            value: 'Sango',
            isCorrect: true
          },
          {
            value: 'Zulu',
            isCorrect: false
          },
          {
            value: 'French',
            isCorrect: false
          }
        ]
      },
      {
        question: 'Ngikhohlwe isambulela sami', //I forgot my umbrella
        languageException : false,
        options: [
          {
            value: 'Sango',
            isCorrect: false
          },
          {
            value: 'Arabic',
            isCorrect: false
          },
          {
            value: 'Zulu',
            isCorrect: true
          },
          {
            value: 'Malagasy',
            isCorrect: false
          }
        ]
      },
      {
        question: 'Ukudla kumnandi', //The food is delicious
        languageException : false,
        options: [
          {
            value: 'Sango',
            isCorrect: false
          },
          {
            value: 'Malagasy',
            isCorrect: false
          },
          {
            value: 'Zulu',
            isCorrect: true
          },
          {
            value: 'Somali',
            isCorrect: false
          }
        ]
      },
      {
        question: 'Nous partirons bientôt', //We'll leave soon
        languageException : false,
        options: [
          {
            value: 'French',
            isCorrect: true
          },
          {
            value: 'Turkish',
            isCorrect: false
          },
          {
            value: 'Malagasy',
            isCorrect: false
          },
          {
            value: 'Zulu',
            isCorrect: false
          }
        ]
      },
      {
        question: 'I\'m taking my uncle to the hospital', //I'm taking my uncle to the hospital
        languageException : false,
        options: [
          {
            value: 'French',
            isCorrect: false
          },
          {
            value: 'Malagasy',
            isCorrect: false
          },
          {
            value: 'Arabic',
            isCorrect: false
          },
          {
            value: 'English',
            isCorrect: true
          }
        ]
      },
      {
        question: 'أنهيت هذا المشروع.', //I finished this project.
        languageException : false,
        options: [
          {
            value: 'Malagasy',
            isCorrect: false
          },
          {
            value: 'Germany',
            isCorrect: false
          },
          {
            value: 'Arabic',
            isCorrect: true
          },
          {
            value: 'Sango',
            isCorrect: false
          }
        ]
      },
      {
        question: 'Ma inaad berri shaqeysaa?', //Do you have to work tomorrow?
        languageException : false,
        options: [
          {
            value: 'Somali',
            isCorrect: true
          },
          {
            value: 'Arabic',
            isCorrect: false
          },
          {
            value: 'Sango',
            isCorrect: false
          },
          {
            value: 'French',
            isCorrect: false
          }
        ]
      }
    ]
    shuffleList(questionList)
    return questionList;
  }

  americaList(): Question[] {
    const questionList: Question[] = [
      {
        question: 'Mañana lloverá', //It will rain tomorrow.
        languageException : false,
        options: [
          {
            value: 'Spanish',
            isCorrect: true
          },
          {
            value: 'French',
            isCorrect: false
          },
          {
            value: 'English',
            isCorrect: false
          },
          {
            value: 'Italian',
            isCorrect: false
          }
        ]
      },
      {
        question: 'I\'m late for work', //I'm late for work
        languageException : false,
        options: [
          {
            value: 'German',
            isCorrect: false
          },
          {
            value: 'English',
            isCorrect: true
          },
          {
            value: 'Spanish',
            isCorrect: false
          },
          {
            value: 'Albanian',
            isCorrect: false
          }
        ]
      },
      {
        question: 'Eu queria ter levado meu guarda-chuva antes de sair de casa', //I wish I'd taken my umbrella before I left the house
        languageException : false,
        options: [
          {
            value: 'English',
            isCorrect: false
          },
          {
            value: 'Spannish',
            isCorrect: false
          },
          {
            value: 'Portuguese',
            isCorrect: true
          },
          {
            value: 'Dutch',
            isCorrect: false
          }
        ]
      },
      {
        question: 'le déjeuner était bon', //lunch was good
        languageException : false,
        options: [
          {
            value: 'Korean',
            isCorrect: false
          },
          {
            value: 'Finnish',
            isCorrect: false
          },
          {
            value: 'French',
            isCorrect: true
          },
          {
            value: 'Filipino',
            isCorrect: false
          }
        ]
      },
      {
        question: 'We vertrekken binnenkort', //We'll be leaving soon
        languageException : false,
        options: [
          {
            value: 'Dutch',
            isCorrect: true
          },
          {
            value: 'Filipino',
            isCorrect: false
          },
          {
            value: 'French',
            isCorrect: false
          },
          {
            value: 'Spannish',
            isCorrect: false
          }
        ]
      },
      {
        question: 'Che araha hĩna che tio tasyõpe', //I'm taking my uncle to the hospital
        languageException : false,
        options: [
          {
            value: 'French',
            isCorrect: false
          },
          {
            value: 'Spannish',
            isCorrect: false
          },
          {
            value: 'Portuguese',
            isCorrect: false
          },
          {
            value: 'Guarani',
            isCorrect: true
          }
        ]
      },
      {
        question: 'Chay llankʼayta tukucharqani', //I finished this project.
        languageException : false,
        options: [
          {
            value: 'Portuguese',
            isCorrect: false
          },
          {
            value: 'Guarani',
            isCorrect: false
          },
          {
            value: 'Quechua',
            isCorrect: true
          },
          {
            value: 'Spannish',
            isCorrect: false
          }
        ]
      },
      {
        question: 'Do you have to work tomorrow?', //Do you have to work tomorrow?
        languageException : false,
        options: [
          {
            value: 'English',
            isCorrect: true
          },
          {
            value: 'Spannish',
            isCorrect: false
          },
          {
            value: 'Dutch',
            isCorrect: false
          },
          {
            value: 'French',
            isCorrect: false
          }
        ]
      }
    ]
    shuffleList(questionList)
    return questionList;
  }
}