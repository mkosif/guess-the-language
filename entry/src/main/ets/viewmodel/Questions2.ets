import { Question } from '../model/Question';
import {shuffleList} from '../utils/ShuffleList'

export function asiaList(): Question[] {
  const questionList: Question[] = [
    {
      question: '明天会下雨', //It will rain tomorrow.
      languageException: false,

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
      languageException: false,
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
      languageException: false,
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
      languageException: 'NotoSansDevanagari',
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
      languageException: false,
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
      languageException: false,
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
      languageException: false,
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
      languageException: false,
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

export function europeList(): Question[] {
  const questionList: Question[] = [
    {
      question: 'It will rain tomorrow.', //It will rain tomorrow.
      languageException: false,
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
      languageException: false,
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
      languageException: false,
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
      languageException: false,
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
      languageException: false,
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
      languageException: false,
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
      languageException: false,
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
      languageException: false,
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