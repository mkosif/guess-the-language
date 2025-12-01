> **Note:** To access all shared projects, get information about environment setup, and view other guides, please visit [Explore-In-HMOS-Wearable Index](https://github.com/Explore-In-HMOS-Wearable/hmos-index).

# Language Guesser

The app allows users to play a mini quiz by choosing a continent and answering timed questions. Players receive immediate audio feedback for correct and incorrect answers, and a final score is shown at the end of each round.
Also can trace of last 7 day's score and correction averages in stats screen

# Preview

<div>
  <img src="screenshots/1.gif" width="24%">
  <img src="screenshots/2.png" width="24%">
  <img src="screenshots/3.png" width="24%">
  <img src="screenshots/4.png" width="24%">
</div>

# Use Cases

- Select a continent and start the quiz for the languages written here
- Shuffle question list with Fisher-Yates algorithm
- Answer language questions under a 10-second timer
- Get instant audio feedback for right and wrong answers
- View the final score at the end of the quiz
- View your weekly performance on 2 different chart based on score and percentage
- Custom font importing that not supported on default

# Tech Stack

- **Languages**: ArkTS, ArkUI
- **Frameworks**: HarmonyOS SDK 6.0.0(20)
- **Tools**: DevEco Studio Version 6.0.0
- **Libraries**:
    - `@kit.ArkUI`
    - `@kit.AbilityKit`
    - `@kit.BasicServicesKit`
    - `@kit.PerformanceAnalysisKit`
    - `@kit.MediaKit`
    - `@kit.AudioKit`

# Directory Structure

```
entry/
├── src/main/ets/
│ ├── components/
│ │ ├── CustomButton.ets
│ │ ├── CustomText.ets
│ │ └── QuestionOptions.ets
│ │
│ ├── entryability/
│ │ └── EntryAbility.ets
│ │
│ ├── entrybackupability/
│ │ └── EntryBackupAbility.ets
│ │
│ ├── model/
│ │ ├── Question.ets
│ │ └── Score.ets
│ │
│ ├── pages/
│ │ ├── Index.ets
│ │ ├── MainScreen.ets
│ │ ├── ContinentChooseScreen.ets
│ │ ├── HowToScreen.ets
│ │ ├── StatsScreen.ets
│ │ ├── QuizScreen.ets
│ │ └── ScoreScreen.ets 
│ │
│ ├── utils/
│ │ └── ScoreStorage.ets
│ │
│ └── viewmodel/
│   └── Questions.ets
```

# Constraints and Restrictions
## Supported Device

* Huawei Watch 5

# License

**Language Guesser** is distributed under the terms of the MIT License

See the [LICENSE](./LICENSE) for more information.
