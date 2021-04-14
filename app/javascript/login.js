function login () {

  // ログインボタンの要素を取得
  const loginBtn = document.querySelectorAll('.login_btn');

  // email入力フォームを取得
  const email = document.getElementById('user_email');
  
  
  // ログインボタンがクリックされた時の処理
  loginBtn.forEach(btn => {
    btn.addEventListener('click', () => {
      
      // パスワード入力欄を取得し、パスワードをセット
      const password = document.getElementById('user_password');
      password.setAttribute('value', '123456');
      // アカウントごとにセットするemailを分岐
      if (btn.id == 'login_btn1') {
        email.setAttribute('value', 'test1@test');
      } else if (btn.id == 'login_btn2') {
        email.setAttribute('value', 'test2@test');
      }

      const form = document.getElementById('form');
      form.method = 'post';
      form.action = '/users/sign_in';
      form.submit();

    });
  });

};

window.addEventListener('load', login);