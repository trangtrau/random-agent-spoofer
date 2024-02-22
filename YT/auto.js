(async function(){
await WaitForLoading ();
const linkApi = 'https://envitech.fun/api.php?key=api_key_hoanglong&'
Navigate ('https://myaccount.google.com/signinoptions/two-step-verification');
await WaitForLoading ();
await CheckAcc();
  
return;
  
let url = null ;
url = await HttpRequest ("https://envitech.fun/link.txt");
Log (url)

Navigate ("https://www.youtube.com/");
await WaitForLoading ();
await randomDelay(5,20);
await ClickRandomLink();
await randomDelay(5,20);
Log ("chuyển sang link mới");
await ClickRandomLink();
await randomDelay(5,20);
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
async function CheckAcc() {
    await Navigate("https://myaccount.google.com/signinoptions/two-step-verification");
    await WaitForLoading ();

    const checkConds = {
        "veriOtpLogin2": 'iframe[title="reCAPTCHA"]',
        "restart": 'a[href*="restart"]',
        "vermail": 'div[data-accountrecovery="false"]',
        "gmailexit": 'input[type="email"][value*="@gmail.com"]',
        "inputPass": 'input[type="password"][name="Passwd"]',
        "addphone": 'input[type="tel"][autocomplete="tel"]',
        
    }
    
    
    const whatNext = await WaitForFirstElement(checkConds, 10);
    Log(whatNext);
    
    if (!whatNext) {
    // Xử lý trường hợp whatNext là null ở đây
    await Navigate("https://myaccount.google.com/signinoptions/two-step-verification");
    return false;
}
        switch (whatNext.key) {
            case "welcomeNew": {
                await ClickBySelector(checkConds["welcomeNew"]);
                return "OK";
            }
            case "restart": {
                await ClickBySelector (`a[href*="restart"]`);
                return "restart";
            }
            
            case "gmailexit": {
                let mail = await GetAttribute (`//*[@id="hiddenEmail"]`, 'value');
                const mailData = await HttpRequest(`${linkApi}gmail=${mail}`);
                Log (mailData)
                const getMail = JSON.parse(mailData);
                await ClickBySelector ('[name="Passwd"]');
                Log("typing pass");
                await Typing (getMail.pass + "\r");
                let ipv6 = await HttpRequest(`http://ipv6-test.com/api/myip.php`);
                Log (ipv6)
                await HttpRequest(`${linkApi}update=true&conditions[gmail]=${mail}&data[ip]=${ipv6}`);
                return "gmailexit";
            }
            
            
            case "addphone": {
                Log ("gmail exit");
                const result = await GetAttribute (`//a[contains(@href, 'https://accounts.google.com/SignOutOptions?')]`, 'aria-label');
                const emailRegex = /\b[\w.%+-]+@[A-Za-z0-9.-]+\.[A-Z|a-z]{2,}\b/;
                const match = result.match(emailRegex);
                let mail = match[0];
                Log (mail);
                let ipv6 = await HttpRequest(`http://ipv6-test.com/api/myip.php`);
                Log (ipv6);
                await HttpRequest(`${linkApi}update=true&conditions[gmail]=${mail}&data[ip]=${ipv6}`);
                return "gmailexit";
            }
            
            case "vermail": {
                await ClickByXpath(`//div[contains(text(),'Confirm your recovery email')]`);
                await WaitForElmToAppear(`input[aria-label="Enter recovery email address"]`);
                await Typing(mailKp);
                await ClickByXpath(`//span[contains(text(),'Next')]`);
                return "OK";
            }
            default: {
                await Navigate ("https://myaccount.google.com/signinoptions/two-step-verification");
                return false;
                break;
            }
        }
        
}

async function randomDelay(min, max) {
  min = Math.ceil(min);
  max = Math.floor(max);
  const delay = Math.floor(Math.random() * (max - min + 1)) + min;
  await WaitForElmToAppear("#submit-btn-vandeptrai-nhatvietss", delay); 
}
    
    
})();
