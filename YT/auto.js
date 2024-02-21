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
Navigate ("https://www.youtube.com/");
await WaitForLoading ();
await randomDelay(15,20);
await ClickRandomLink();
await randomDelay(15,20);
Log ("chuyển sang link mới");
await ClickRandomLink();
await randomDelay(15,20);
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
