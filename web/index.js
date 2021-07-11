const webcamElement = document.getElementById('webcam');
const canvasElement = document.getElementById('canvas');
const snapSoundElement = document.getElementById('snapSound');
const webcam = new Webcam(webcamElement, 'environment', canvasElement, snapSoundElement)
const btn = document.querySelector(".clickme")
const stopBtn = document.querySelector(".stop")
const flipBtn = document.querySelector(".flip")
const vd = document.querySelector(".vd")
let continuousPicture;


//threshold values

const token = "1bbb8a5f-5977-425e-9733-fdcc5a0ad685";

function sendEmail(reason) {
    Email.send({
        SecureToken : token,
        To : 'shruti.g2121@gmail.com',
        From : "konnectprototype@gmail.com",
        Subject : "This is the subject",
        Body : "And this is the body"
    }).then(
      message => alert(message)
    );
}

sendEmail("reason")

// const heartrate = [90,100]
// const firstbp = [90, 130]
// const secondbp = [70,100]
// const temp = [97,99]
// const respiration = [16,20]
// const oxygen = [92,100]


// const ref = [heartrate, firstbp, secondbp, temp, respiration, oxygen]


// function compare(temp) {

//     for(let i=0; i < temp.length; i++){
//         console.log(ref[i])
//         if(temp[i] < ref[i][0] || temp[i] >= ref[i][1]){
            

//             //send Email
//         }
//     }

// }


// webcam.start()
//     .then(result =>{
//         console.log("webcam started");
  
//     })
//     .catch(err => {
//         console.log(err);
// });

// stopBtn.addEventListener("click", () => {
//     webcam.stop()
//     clearInterval(continuousPicture);
// });
// flipBtn.addEventListener("click", () => {
//     webcam.flip();
// });

// btn.addEventListener("click", () => {
//     // recognize();
//     continuousPicture = setInterval(recognize, 10000);
// });
// function recognize() {
//     // console.log("hi")
//     let picture = webcam.snap();
//     let temp = []
//     let item;
//     let n;
//     let nitem;
    
   


//        Tesseract.recognize(
//         picture,
//         'eng',
        
//       ).then(({ data: { text } }) => {
        
//         const output = text.split("\n");


        
//         vd.textContent = text;

        
        
//            //parse data
//             for(let i=0; i < output.length; i++){

//                 // console.log(output[i])
//                 if(output[i].includes("/")) {
//                     n = output[i].split("/");
//                     for(let j=0; j < n.length; j++){
//                         nitem = parseInt(n[j])
//                         if(!isNaN(nitem)){
//                             temp.push(nitem)
//                         }
//                     }
//                 }else{
//                     item = parseInt(output[i])
//                     if(!isNaN(item)){
//                         temp.push(item)
//                     }
//                 }
                
//             }
            
        
//         console.log(temp);
//         //compare values
//         compare(temp)


     
//     })

 
    
    
    
   
//     // console.log("dwnld")
//     // document.querySelector('#download-photo').href = picture;

//     // Tesseract.recognize(
//     //     picture,
//     //     'eng',
//     //     { logger: m => console.log(m) }
//     //   ).then(({ data: { text } }) => {
//     //     console.log(text);
//     //     vd.textContent = text;
//     // })
// }

