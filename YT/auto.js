
(async function(){
async function Login() {
   const checkConds = {
	"restart": 'a[href*="restart"]',
      	"recapcha": 'img[id="captchaimg"][src]:not([src=""])',
      	"gmailexit": 'input[type="email"][value*="@gmail.com"]',
      	"login": 'input#identifierId[value=""]',
      	"inputPass": 'input[type="password"][name="Passwd"]',
      	"vermail": 'div[data-accountrecovery="false"]',
        "needrecovery": '#accountRecoveryButton',
        "gmailDie": 'iframe[title="reCAPTCHA"]',
        "gmailDie2": '#phoneNumberId',
        
        "addphone": 'input[type="tel"][autocomplete="tel"]',
    } 
    let attempts = 0;
    while (attempts < 20) {
    const whatNext = await WaitForFirstElement2(checkConds, 0.5);
    switch (whatNext) {
            case "gmailDie":
            case "gmailDie2":    
                {
			  Log ("Gmail Die, lấy mail khác");
                await HttpRequest(`${linkApi}update=true&conditions[gmail]=${getMail.gmail}&data[die]=1`);
                await Navigate("https://myaccount.google.com/signinoptions/two-step-verification?hl=en");
                await WaitForLoading ();
		        let mailData = await HttpRequest(`${linkApi}ip=ipv6`);
                getMail = JSON.parse(mailData);
                Log (getMail)
                if (getMail.status === false) {
                    let mailData = await HttpRequest(`${linkApi}ip=null&die=null`);
                    getMail = JSON.parse(mailData);
                }
                Log (getMail);
                break;
            }
            case "restart": {
                Log ("Click Restart");
                await ClickBySelector (`a[href*="restart"]`);
                break;
            }
		
	    case "recapcha": {
	            Log ("Nhập recapcha");
                const result = await SolveImageCaptcha("#captchaimg", "#ca", "anti-captcha", "6dee77ab7a8c947e5de288af88b34bb1",45)
                Log(result);
                await SendKeyPress (K_ENTER);
		        await randomDelay(1,2);
                break;
            }

            
             case "needrecovery": {
                Log ("Acc bị recovery");
                await HttpRequest(`${linkApi}update=true&conditions[gmail]=${getMail.gmail}&data[die]=2`);
                await Navigate("https://myaccount.google.com/signinoptions/two-step-verification?hl=en");
                let mailData = await HttpRequest(`${linkApi}ip=null&die=null`);
                getMail = JSON.parse(mailData);
                break;
            }
            
            case "login": {
                Log ("Nhập Acc");
                let ipv6 = await HttpRequest(`http://ipv6-test.com/api/myip.php`);
                let mailData = await HttpRequest(`${linkApi}ip=${ipv6}`);
                getMail = JSON.parse(mailData);
                if (getMail.status === false) {  let mailData = await HttpRequest(`${linkApi}ip=null&die=null`);      getMail = JSON.parse(mailData);          }
                Log (getMail);

		        await ClickBySelector (`input#identifierId[value=""]`);
		        await Typing (getMail.gmail.trim() + "\r",100,200);
		        importUser = 1;
		        await randomDelay(1,2);
                break;
            }
            case "gmailexit": {
                if(importUser = 0){
                Log ("Acc đã tồn tại, OK");
                let mail = await GetAttribute (`//*[@id="hiddenEmail"]`, 'value');
                const mailData = await HttpRequest(`${linkApi}gmail=${mail}`);
                Log (mailData)
                let ipv6 = await HttpRequest(`http://ipv6-test.com/api/myip.php`);
                Log (ipv6)
                await HttpRequest(`${linkApi}update=true&conditions[gmail]=${mail}&data[ip]=${ipv6}`);
		attempts = 99;
                Exit();
                } else {
                     Log ("Nhập Pass");
			await ClickBySelector (`div[role="combobox"][aria-haspopup="listbox"]`);
		        await randomDelay(2,3);
		        await ClickBySelector (`li[data-value="en-US"]`);
		        await randomDelay(3,4);
			await ClickBySelector (`input[type="password"][name="Passwd"]`);
                     	await Typing (getMail.pass.trim() + "\r",100,200);
                     	await randomDelay(2,3);
		     	const source = await GetSource();
			const isFound = source.includes("Try again or click Forgot password to reset it");
			if (isFound) {
			Log ("Sai Pass");	
   			await HttpRequest(`${linkApi}update=true&conditions[gmail]=${getMail.gmail}&data[die]=3`);
			let ipv6 = await HttpRequest(`http://ipv6-test.com/api/myip.php`);
                	let mailData = await HttpRequest(`${linkApi}ip=${ipv6}`);
                	getMail = JSON.parse(mailData);
                	if (getMail.status === false) {  let mailData = await HttpRequest(`${linkApi}ip=null&die=null`);      getMail = JSON.parse(mailData);          }
                	Log (getMail);
			await Navigate("https://myaccount.google.com/signinoptions/two-step-verification?hl=en");
			importUser = null;     
		    	 }   		
                    
                }
                break;
            }
            
            case "addphone": {
                Log ("Acc đã tồn tại, OK");
                const result = await GetAttribute (`//a[contains(@href, 'https://accounts.google.com/SignOutOptions?')]`, 'aria-label');
                const emailRegex = /\b[\w.%+-]+@[A-Za-z0-9.-]+\.[A-Z|a-z]{2,}\b/;
                const match = result.match(emailRegex);
                let mail = match[0];
                Log (mail);
                let ipv6 = await HttpRequest(`http://ipv6-test.com/api/myip.php`);
                await HttpRequest(`${linkApi}update=true&conditions[gmail]=${mail}&data[ip]=${ipv6}`);
		            attempts = 99;
                Exit();
                break;
            }
            case "vermail": {
                Log ("Nhập mail khôi phục");
		            await randomDelay(1,2);
		            await ClickBySelector (`div[role="combobox"][aria-haspopup="listbox"]`);
		            await randomDelay(2,3);
		            await ClickBySelector (`li[data-value="en-US"]`);
		            await randomDelay(3,4);
                await ClickByXpath(`//div[contains(text(), 'Xác nhận email khôi phục') or contains(text(), 'Confirm your recovery email')]`);
                await WaitForElmToAppear(`input[aria-label="Enter recovery email address"]`);
                await Typing(getMail.recovery,100,200);
                await ClickByXpath(`//span[contains(text(),'Next')]`);
                await randomDelay(10,15);
                Exit();
                break;
            }
            default: {
                await Navigate ("https://myaccount.google.com/signinoptions/two-step-verification?hl=en");
                return false;
                break;
            }
        }
        attempts++;
    }
 }

async function WaitForFirstElement2(checkConds, timeout) {
    for (const key in checkConds) {
        const selector = checkConds[key];
        try {
            const checkExit =  await WaitForElement(selector, (elm) => !!elm, timeout);
            if(checkExit){return key;}
        } catch (error) {
        }
    }
    throw new Error("Không tìm thấy phần tử cho bất kỳ điều kiện nào");
}

async function randomDelay(min, max) {
  min = Math.ceil(min);
  max = Math.floor(max);
  const delay = Math.floor(Math.random() * (max - min + 1)) + min;
  await WaitForElmToAppear("#submit-btn-vandeptrai-nhatvietss", delay); 
}

//kết thúc khai báo hàm
//RUN CODE
let importUser = 0;
let getMail = null;
const linkApi = 'https://envitech.fun/api.php?key=api_key_hoanglong&'
let url = null ;
url = await HttpRequest ("https://envitech.fun/link.php?type=youtube");
Log (url)

const randomUrl = await HttpRequest("https://envitech.fun/link.php");
await WaitForLoading ();
Log ("Check tình trạng login!");
await Navigate("https://myaccount.google.com/signinoptions/two-step-verification?hl=en");
await WaitForLoading ();
await Login();	
await Navigate("https://accounts.google.com/ServiceLogin?service=youtube");
Navigate (randomUrl);
await WaitForLoading ();
await randomDelay(5,10);
Log ("Chuyển sang link ngẫu nhiên!");
await ClickRandomLink();
await randomDelay(5,10);
Log ("Chuyển sang link ngẫu nhiên!");
await ClickRandomLink();
await randomDelay(5,10);
	


    
})();
