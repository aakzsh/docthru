
  // Initialize Firebase
const fb =  firebase.initializeApp(firebaseConfig);
const emailInput = document.querySelector('.email');
const passwordInput = document.querySelector('.password');
const loginBtn = document.querySelector('.login-btn');





loginBtn.addEventListener('click', (e) => {
    e.preventDefault();
    const email = emailInput.value;
    const password = passwordInput.value;

    const auth = fb.auth();

    auth.createUserWithEmailAndPassword(email, password)
        .then(() => {
            console.log('Signed Up Successfully !');
            window.location.href = "index.html"
    }).catch(error => {
        console.log(error);
    })

})



