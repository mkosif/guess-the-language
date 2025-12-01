import { Question } from '../model/Question';

export class Questions {
  private unitMap: Map<string, () => []>;

  constructor() {
    this.unitMap = new Map<string, () => []>();

    this.unitMap.set('All', this.allList.bind(this));
    this.unitMap.set('Asia', this.asiaList.bind(this));
    this.unitMap.set('Europe', this.europeList.bind(this));
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
    const allList: Question[] = [...this.asiaList(), ...this.europeList(), ...this.africaList(), ...this.americaList()]
    //console.info('AllList is : ' + allList.length)
    shuffleList(allList)
    return allList;
  }


  /* TODO Hindi doesn't show up */
  asiaList(): Question[] {
    const questionList: Question[] = [
      {
        question: '明天会下雨', //It will rain tomorrow.
        languageException : false,

        options: [
          {
            value: 'Chinese',
            isCorrect: true
          },
          {
            value: 'Japanese',
            isCorrect: false
          },
          {
            value: 'Korean',
            isCorrect: false
          },
          {
            value: 'Hindi',
            isCorrect: false
          }
        ]
      },
      {
        question: '私は仕事に遅れています', //I'm late for work
        languageException : false,
        options: [
          {
            value: 'Korean',
            isCorrect: false
          },
          {
            value: 'Japanese',
            isCorrect: true
          },
          {
            value: 'Indonesian',
            isCorrect: false
          },
          {
            value: 'Welsh',
            isCorrect: false
          }
        ]
      },
      {
        question: 'Tuklu evden bi dəfə semsiyemi alsa ydim', //I wish I'd taken my umbrella before I left the house
        languageException : false,
        options: [
          {
            value: 'Albanian',
            isCorrect: false
          },
          {
            value: 'Finnish',
            isCorrect: false
          },
          {
            value: 'Azerbaijani',
            isCorrect: true
          },
          {
            value: 'Kazakh',
            isCorrect: false
          }
        ]
      },
      {
        question: 'दोपहर का खाना अच्छा था', //lunch was good
        languageException : 'NotoSansDevanagari',
        options: [
          {
            value: 'Korean',
            isCorrect: false
          },
          {
            value: 'Thai',
            isCorrect: false
          },
          {
            value: 'Hindi',
            isCorrect: true
          },
          {
            value: 'Hebrew',
            isCorrect: false
          }
        ]
      },
      {
        question: 'Бид удахгүй явна', //We'll be leaving soon
        languageException : false,
        options: [
          {
            value: 'Mongolian',
            isCorrect: true
          },
          {
            value: 'Kazakh',
            isCorrect: false
          },
          {
            value: 'Georgian',
            isCorrect: false
          },
          {
            value: 'Hindi',
            isCorrect: false
          }
        ]
      },
      {
        question: 'Tôi sẽ đưa chú tôi đến bệnh viện', //I'm taking my uncle to the hospital
        languageException : false,
        options: [
          {
            value: 'Chinese',
            isCorrect: false
          },
          {
            value: 'Indonesian',
            isCorrect: false
          },
          {
            value: 'Thai',
            isCorrect: false
          },
          {
            value: 'Vietnamese',
            isCorrect: true
          }
        ]
      },
      {
        question: 'ผมทําโครงการนี้เสร็จ', //I finished this project.
        languageException : false,
        options: [
          {
            value: 'Japanese',
            isCorrect: false
          },
          {
            value: 'Chinese',
            isCorrect: false
          },
          {
            value: 'Thai',
            isCorrect: true
          },
          {
            value: 'Austronesian',
            isCorrect: false
          }
        ]
      },
      {
        question: '내일 일 있어요?', //Do you have work tomorrow?
        languageException : false,
        options: [
          {
            value: 'Korean',
            isCorrect: true
          },
          {
            value: 'Japanese',
            isCorrect: false
          },
          {
            value: 'Chinese',
            isCorrect: false
          },
          {
            value: 'Uzbek',
            isCorrect: false
          }
        ]
      }
    ]
    shuffleList(questionList)
    return questionList;
  }

  europeList(): Question[] {
    const questionList: Question[] = [
      {
        question: 'It will rain tomorrow.', //It will rain tomorrow.
        languageException : false,
        options: [
          {
            value: 'English',
            isCorrect: true
          },
          {
            value: 'French',
            isCorrect: false
          },
          {
            value: 'Spanish',
            isCorrect: false
          },
          {
            value: 'Italian',
            isCorrect: false
          }
        ]
      },
      {
        question: 'Llego tarde al trabajo', //I'm late for work
        languageException : false,
        options: [
          {
            value: 'Turkish',
            isCorrect: false
          },
          {
            value: 'Spanish',
            isCorrect: true
          },
          {
            value: 'Serbian',
            isCorrect: false
          },
          {
            value: 'Albanian',
            isCorrect: false
          }
        ]
      },
      {
        question: 'Olisinpa ottanut sateenvarjoni ennen lähtöäni', //I wish I'd taken my umbrella before I left the house
        languageException : false,
        options: [
          {
            value: 'English',
            isCorrect: false
          },
          {
            value: 'Norwegian',
            isCorrect: false
          },
          {
            value: 'Finnish',
            isCorrect: true
          },
          {
            value: 'Kazakh',
            isCorrect: false
          }
        ]
      },
      {
        question: 'Az ebéd jó volt', //lunch was good
        languageException : false,
        options: [
          {
            value: 'Korean',
            isCorrect: false
          },
          {
            value: 'Thai',
            isCorrect: false
          },
          {
            value: 'Hungarian',
            isCorrect: true
          },
          {
            value: 'Greek',
            isCorrect: false
          }
        ]
      },
      {
        question: 'Θα φύγουμε σύντομα', //We'll be leaving soon
        languageException : false,
        options: [
          {
            value: 'Greek',
            isCorrect: true
          },
          {
            value: 'Croatian',
            isCorrect: false
          },
          {
            value: 'Polish',
            isCorrect: false
          },
          {
            value: 'Czech',
            isCorrect: false
          }
        ]
      },
      {
        question: 'Îl duc pe unchiul meu la spital', //I'm taking my uncle to the hospital
        languageException : false,
        options: [
          {
            value: 'German',
            isCorrect: false
          },
          {
            value: 'Macedonian',
            isCorrect: false
          },
          {
            value: 'Bulgarian',
            isCorrect: false
          },
          {
            value: 'Romanian',
            isCorrect: true
          }
        ]
      },
      {
        question: 'Projeyi bitirdim', //I finished this project.
        languageException : false,
        options: [
          {
            value: 'Portuguese',
            isCorrect: false
          },
          {
            value: 'Germany',
            isCorrect: false
          },
          {
            value: 'Turkish',
            isCorrect: true
          },
          {
            value: 'Serbian',
            isCorrect: false
          }
        ]
      },
      {
        question: 'Musst du morgen arbeiten?', //Do you have to work tomorrow?
        languageException : false,
        options: [
          {
            value: 'German',
            isCorrect: true
          },
          {
            value: 'Turkish',
            isCorrect: false
          },
          {
            value: 'Swedish',
            isCorrect: false
          },
          {
            value: 'Dutch',
            isCorrect: false
          }
        ]
      }
    ]
    shuffleList(questionList)
    return questionList;
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

//Fisher-Yates Shuffle Algorithm
function shuffleList(questionList: Question[]) {
  // Math.floor(Math.random() * (max - min + 1) + min)
  console.info('Current place - Length: ' + questionList.length)

  for (let i = 0; i < questionList.length; i++) {
    const rand = Math.floor(Math.random() * (questionList.length))
    console.info('Current place: ' + i + ' chosen place: ' + rand)
    const tmp = questionList[rand];
    questionList[rand] = questionList[i]
    questionList[i] = tmp
  }
}