
(async function(){

//khai báo hàm
async function Login(mail,pass,mailKp) {
    Log("Login");
    //await WaitForLoading ();
    await randomDelay(2,5);
    
    const userTextboxSelector = "#identifierId";
    const pwTextboxSelector = '[name="Passwd"]';
    
    Log("wait for mail textbox");
    await WaitForElement(userTextboxSelector, (elm) => !!elm, 10);
    await randomDelay(2,5);
    await ClickBySelector (userTextboxSelector);
    Log("typing mail");
    await Typing (mail.trim() + "\r");
    
    Log("wait for pw textbox");
       let attempts = 0;
    while (attempts < 5) {
        try {
                let checkCapcha =  await WaitForElement(`img[id="captchaimg"][src]:not([src=""])`, (elm) => !!elm, 2);
                if(checkCapcha){
                const result = await SolveImageCaptcha("#captchaimg", "#ca", "anti-captcha", "6dee77ab7a8c947e5de288af88b34bb1",45)
                Log(result);
                await SendKeyPress (K_ENTER);
                }
                let checkPass =  await WaitForElement(pwTextboxSelector, (elm) => !!elm, 1);
                if(checkPass){
                break;
            }

        } catch (error) {
            //console.error("Đăng nhập thất bại:", error);
        }
        attempts++;
    }


    
    await WaitForElement(pwTextboxSelector, (elm) => !!elm, 5);
    await randomDelay(2,5);
    await ClickBySelector (pwTextboxSelector);
    Log("typing pass");
    await Typing (pass.trim() + "\r");
    await randomDelay(5,10);
    await WaitForLoading ();
    
 }


async function checkLogin() {

    const checkConds = {
        "needrecovery": '#accountRecoveryButton',
        "gmailDie": 'iframe[title="reCAPTCHA"]',
        "gmailDie2": '#phoneNumberId',
        "restart": 'a[href*="restart"]',
        "vermail": 'div[data-accountrecovery="false"]',
        "gmailexit": 'input[type="email"][value*="@gmail.com"]',
        "inputPass": 'input[type="password"][name="Passwd"]',
        "addphone": 'input[type="tel"][autocomplete="tel"]',
        "login": 'input#identifierId[value=""]',
        
        
        
    }

    const whatNext = await WaitForFirstElement2(checkConds, 1);
    Log(whatNext);
    
    if (!whatNext) {
    await Navigate("https://myaccount.google.com/signinoptions/two-step-verification");
    return false;
}
        switch (whatNext) {
            case "gmailDie":
            case "gmailDie2":    
                {
                await HttpRequest(`${linkApi}update=true&conditions[gmail]=${getMail.gmail}&data[die]=1`);
                await Navigate("https://myaccount.google.com/signinoptions/two-step-verification");
                await WaitForLoading ();
                return "Die";
            }
            case "restart": {
                await ClickBySelector (`a[href*="restart"]`);
                return "restart";
            }
            
             case "needrecovery": {
                await HttpRequest(`${linkApi}update=true&conditions[gmail]=${getMail.gmail}&data[die]=2`);
                await Navigate("https://myaccount.google.com/signinoptions/two-step-verification");
                await WaitForLoading ();
                return "needrecovery";
            }
            
            case "login": {
                let ipv6 = await HttpRequest(`http://ipv6-test.com/api/myip.php`);
                let mailData = await HttpRequest(`${linkApi}ip=ipv6`);
                getMail = JSON.parse(mailData);
                 Log (getMail)
                if (getMail.status === false) {
                    let mailData = await HttpRequest(`${linkApi}ip=null&die=null`);
                    getMail = JSON.parse(mailData);
                }
                Log (getMail);
                await Login(getMail.gmail,getMail.pass,getMail.recovery)
                return "login";
            }
            
            case "gmailexit": {
                let mail = await GetAttribute (`//*[@id="hiddenEmail"]`, 'value');
                const mailData = await HttpRequest(`${linkApi}gmail=${mail}`);
                Log (mailData)
                let ipv6 = await HttpRequest(`http://ipv6-test.com/api/myip.php`);
                Log (ipv6)
                await HttpRequest(`${linkApi}update=true&conditions[gmail]=${mail}&data[ip]=${ipv6}`);
                return true;
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
                return true;
            }
            
            case "vermail": {
               
                await ClickByXpath(`//div[contains(text(), 'Xác nhận email khôi phục') or contains(text(), 'Confirm your recovery email')]`);
                await WaitForElmToAppear(`input[aria-label="Enter recovery email address"]`);
                await Typing(getMail.recovery);
                await ClickByXpath(`//span[contains(text(),'Next')]`);
                await randomDelay(5,10);
                 let ipv6 = await HttpRequest(`http://ipv6-test.com/api/myip.php`);
                Log (ipv6);
                await HttpRequest(`${linkApi}update=true&conditions[gmail]=${getMail.gmail}&data[ip]=${ipv6}`);
                return true;
            }
            default: {
                await Navigate ("https://myaccount.google.com/signinoptions/two-step-verification");
                return false;
                break;
            }
        }
        
}

async function WaitForFirstElement2(checkConds, timeout) {
    for (const key in checkConds) {
        const selector = checkConds[key];
        try {
            const checkExit =  await WaitForElement(selector, (elm) => !!elm, timeout);
            await randomDelay(1,2);
            if(checkExit){return key;}
        
            
        } catch (error) {
              console.error(`Không tìm thấy phần tử cho điều kiện ${key}`);
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

const phones = [];
await WaitForLoading ();
let getMail = null;
const linkApi = 'https://envitech.fun/api.php?key=api_key_hoanglong&'
let url = null ;
url = await HttpRequest ("https://envitech.fun/link.php?youtube");
Log (url)



await Navigate("https://myaccount.google.com/signinoptions/two-step-verification");
await WaitForLoading ();


 let attempts = 0;
    while (attempts < 5) {
        try {
            const loggedIn = await checkLogin();
            if (loggedIn === true) {
                Log("Đăng nhập thành công!");
                break; // Thoát khỏi hàm nếu đăng nhập thành công
            }
            if (loggedIn === "login" && attempts > 0) {
            attempts--;
            }
        } catch (error) {
            //console.error("Đăng nhập thất bại:", error);
        }
        attempts++;
    }

// Tạo mảng các đường dẫn
const randomUrl = await HttpRequest("https://envitech.fun/link.php");
Navigate (randomUrl);
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
     const newUrl = await HttpRequest("https://envitech.fun/link.php?youtube");

        if (newUrl !== url) {
            url = newUrl;
            console.log("URL mới đã được tìm thấy:", url);
            await ClickRandomLink();
            await randomDelay(5,30);
            Navigate (url);
        }
        await randomDelay(55,120);
     



}

    
})();
