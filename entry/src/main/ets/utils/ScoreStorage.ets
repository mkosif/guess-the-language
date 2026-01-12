import preferences from '@ohos.data.preferences';

const SCORE_PREFERENCE_NAME = 'score_storage';
const COUNT_PREFERENCE_NAME = 'count_storage';
const PERCENT_PREFERENCE_NAME = 'percent_storage';
let scorePref: preferences.Preferences | null = null;
let countPref: preferences.Preferences | null = null;
let percentPref: preferences.Preferences | null = null;

async function getScorePreferences(context: Context): Promise<preferences.Preferences> {
  if (!scorePref) {
    scorePref = await preferences.getPreferences(context, SCORE_PREFERENCE_NAME);
  }
  return scorePref;
}

async function getCountPreferences(context: Context): Promise<preferences.Preferences> {
  if (!countPref) {
    countPref = await preferences.getPreferences(context, COUNT_PREFERENCE_NAME);
  }
  return countPref;
}

async function getPercentPreferences(context: Context): Promise<preferences.Preferences> {
  if (!percentPref) {
    percentPref = await preferences.getPreferences(context, PERCENT_PREFERENCE_NAME);
  }
  return percentPref;
}

function getDateKey(date: Date): string {
  return date.toISOString().slice(0, 10);
}

export async function getLast7Days(context: Context, desiredData: string): Promise<number[]> {
  const scorePreferences = await getScorePreferences(context);
  const countPreferences = await getCountPreferences(context);
  const percentPreferences = await getPercentPreferences(context);
  const today = new Date();
  let result: number[] = [];

  if (desiredData === 'score') {
    let d = new Date(today);
    for (let i = 6; i >= 0; i--) {
      d.setDate(today.getDate() - i);
      const key = getDateKey(d);

      const score = await scorePreferences.get(key, 0);
      const count = await countPreferences.get(key, 0);
      const avg = (count !== 0) ? (score as number) / (count as number) : 0
      result.push(avg as number);
    }
  } else {
    let d = new Date(today);
    for (let i = 6; i >= 0; i--) {
      d.setDate(today.getDate() - i);
      const key = getDateKey(d);

      const percent = await percentPreferences.get(key, 0);
      const count = await countPreferences.get(key, 0);
      const avg = (count !== 0) ? (percent as number) / (count as number) : 0
      result.push(avg as number);
    }
  }

  return result;
}

export async function storeScore(context: Context, quizScore: number, quizPercent: number): Promise<void> {
  const scorePreferences = await getScorePreferences(context);
  const countPreferences = await getCountPreferences(context);
  const percentPreferences = await getPercentPreferences(context);
  const todayKey = getDateKey(new Date());

  const currentScore = await scorePreferences.get(todayKey, 0);
  const currentCount = await countPreferences.get(todayKey, 0);
  const currentPercent = await percentPreferences.get(todayKey, 0);
  const newScore = (currentScore as number) + quizScore;
  const newPercent = (currentPercent as number) + quizPercent;
  const newCount = (currentCount as number) + 1;

  await scorePreferences.put(todayKey, newScore);
  await countPreferences.put(todayKey, newCount);
  await percentPreferences.put(todayKey, newPercent);
  await scorePreferences.flush();
  await countPreferences.flush();
  await percentPreferences.flush();
}

//Resetting today's data for testing
export async function resetToday(context: Context): Promise<void> {
  const scorePreferences = await getScorePreferences(context);
  const countPreferences = await getCountPreferences(context);
  const percentPreferences = await getPercentPreferences(context);
  const todayKey = getDateKey(new Date());

  const newScore = 0;
  const newPercent = 0;
  const newCount = 0;

  await scorePreferences.put(todayKey, newScore);
  await countPreferences.put(todayKey, newCount);
  await percentPreferences.put(todayKey, newPercent);
  await scorePreferences.flush();
  await countPreferences.flush();
  await percentPreferences.flush();
}