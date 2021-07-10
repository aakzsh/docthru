const webcamElement = document.getElementById('webcam');
const canvasElement = document.getElementById('canvas');
const snapSoundElement = document.getElementById('snapSound');
const webcam = new Webcam(webcamElement, 'environment', canvasElement, snapSoundElement)
const btn = document.querySelector(".clickme")
const stopBtn = document.querySelector(".stop")
const flipBtn = document.querySelector(".flip")
const vd = document.querySelector(".vd")
webcam.start()
    .then(result =>{
        console.log("webcam started");
  
    })
    .catch(err => {
        console.log(err);
});

          

stopBtn.addEventListener("click", () => {
    webcam.stop()
});

flipBtn.addEventListener("click", () => {
    webcam.flip()
});

btn.addEventListener("click", () => {
    let picture = webcam.snap();
    console.log(picture)
    // console.log("dwnld")
    // document.querySelector('#download-photo').href = picture;
    Tesseract.recognize(
    picture,
    'eng',
    { logger: m => console.log(m) }
  ).then(({ data: { text } }) => {
    console.log(text);
    vd.textContent = text;
  })
    
})

// Tesseract.recognize(
//     'lol.jpg',
//     'eng',
//     { logger: m => console.log(m) }
//   ).then(({ data: { text } }) => {
//     console.log(text);
//   })

//tesseract
// const worker = createWorker({
//     logger: m => console.log(m)
//   });
  
//   (async () => {
//     await worker.load();
//     await worker.loadLanguage('eng');
//     await worker.initialize('eng');
//     const { data: { text } } = await worker.recognize('dc.png');
//     console.log(text);
//     await worker.terminate();
//   })();