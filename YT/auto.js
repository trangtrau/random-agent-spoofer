(async function(){
await WaitForLoading ();
let url = null ;
url = await HttpRequest ("https://envitech.fun/link.txt");
Log (url)
async function randomDelay(min, max) {
  min = Math.ceil(min);
  max = Math.floor(max);
  const delay = Math.floor(Math.random() * (max - min + 1)) + min;
  await WaitForElmToAppear("#submit-btn-vandeptrai-nhatvietss", delay); 
}

await ClickRandomLink();
await randomDelay(5,10);
Log ("chuyển sang link mới");
await ClickRandomLink();
await randomDelay(5,10);
Log ("chuyển sang link chính");
Navigate (url);
 while (true) {
     const newUrl = await HttpRequest("https://envitech.fun/link.txt");

        if (newUrl !== url) {
            url = newUrl;
            console.log("URL mới đã được tìm thấy:", url);
            Navigate (url);
        }
        await randomDelay(55,120);
     
 }
 
    
    
})();
