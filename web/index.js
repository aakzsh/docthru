const webcamElement = document.getElementById('webcam');
const canvasElement = document.getElementById('canvas');
const snapSoundElement = document.getElementById('snapSound');
const webcam = new Webcam(webcamElement, 'environment', canvasElement, snapSoundElement)
const btn = document.querySelector(".clickme")
const stopBtn = document.querySelector(".stop")
const flipBtn = document.querySelector(".flip")
const vd = document.querySelector(".vd")
let continuousPicture;



webcam.start()
    .then(result =>{
        console.log("webcam started");
  
    })
    .catch(err => {
        console.log(err);
});

stopBtn.addEventListener("click", () => {
    webcam.stop()
    clearInterval(continuousPicture);
});
flipBtn.addEventListener("click", () => {
    webcam.flip();
});

btn.addEventListener("click", () => {
    // recognize();
    continuousPicture = setInterval(recognize, 10000);
});
function recognize() {
    // console.log("hi")
    let picture = webcam.snap();
    let temp = []
    let item;
    let n;
    let nitem;
    
   


       Tesseract.recognize(
        picture,
        'eng',
        
      ).then(({ data: { text } }) => {
        
        const output = text.split("\n");


        
        vd.textContent = text;

        
        
           //parse data
            for(let i=0; i < output.length; i++){

                // console.log(output[i])
                if(output[i].includes("/")) {
                    n = output[i].split("/");
                    for(let j=0; j < n.length; j++){
                        nitem = parseInt(n[j])
                        if(!isNaN(nitem)){
                            temp.push(nitem)
                        }
                    }
                }else{
                    item = parseInt(output[i])
                    if(!isNaN(item)){
                        temp.push(item)
                    }
                }
                
            }
            
        
        console.log(temp);
        


     
    })

 
    
    
    
   
    // console.log("dwnld")
    // document.querySelector('#download-photo').href = picture;

    // Tesseract.recognize(
    //     picture,
    //     'eng',
    //     { logger: m => console.log(m) }
    //   ).then(({ data: { text } }) => {
    //     console.log(text);
    //     vd.textContent = text;
    // })
}

