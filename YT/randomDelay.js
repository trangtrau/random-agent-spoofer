  min = Math.ceil(min);
  max = Math.floor(max);
  const delay = Math.floor(Math.random() * (max - min + 1)) + min;
  await WaitForElmToAppear("#submit-btn-vandeptrai-nhatvietss", delay); 
