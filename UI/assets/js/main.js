const baseUrl = '';
const token = `${localStorage.token}`;
const createRequestForm = document.querySelector('#output');
const userRequest = document.querySelector('#body');


/*
* Adds an eventListener with a callback to GET all requests for a logged in user
*/
const getRequest = () => {
  fetch(`${baseUrl}/users/requests`, {
    method: 'GET',
    headers: {
      Accept: 'application/json, text/plain, */*',
      'Content-type': 'application/json',
      'x-access-token': token,
    },
  }).then(res => res.json())
    .then((data) => {
      if (data.success === true) {
        if (sessionStorage.getItem('requests') === null || sessionStorage.getItem('requests') !== data) {
          const requests = [];
          requests.push(data);
          sessionStorage.setItem('requests', JSON.stringify(requests));
        } else {
          const requests = JSON.parse(sessionStorage.getItem('requests'));
          requests.push(data);
          sessionStorage.setItem('requests', JSON.stringify(requests));
        }

        const userData = JSON.parse(sessionStorage.getItem('requests'));
        const myRequest = document.querySelector('#request');

        myRequest.innerHTML = '';
        for (let n = 0; n <= Object.keys(userData[0]).length - 3; n += 1) {
          const title = `${userData[0][n].title}`;
          const department = `${userData[0][n].department}`;
          const details = `${userData[0][n].details}`;
          const status = `${userData[0][n].status}`;
          myRequest.innerHTML += `<section class="request wallpaper">
        <a href="#">
          <div class="tag"><h1 class="request-title">${title}</h1>
          <h2 class="badge">${status}</h2></div>
          <small class="sub-title">${department}</small>
          <button type="submit" class="edit">EDIT</button>
          <button type="submit" class="delete">DELETE</button>
          <h2 class="sub-title">Details</h2>
          <p class="page-info">${details}</p>
        </a>
      </section>`;
        }
      }
    }).catch((error) => {
      document.querySelector('#error')
        .innerHTML = `<h2>server error<h2/>
        <h3>${error}<h3/>`;
    });
};

/*
* Adds an eventListener with a callback to POST user request inputs
*
* @param {object} submitEvent - The submitEvent
*/
if (createRequestForm) {
  createRequestForm.addEventListener('submit', (e) => {
    e.preventDefault();
    const title = document.querySelector('#title').value;
    const department = document.querySelector('#department').value;
    const details = document.querySelector('#details').value;

    fetch(`${baseUrl}/users/requests`, {
      method: 'POST',
      headers: {
        Accept: 'application/json, text/plain, */*',
        'Content-type': 'application/json',
        'x-access-token': token,
      },
      body: JSON.stringify({ title, department, details }),
    }).then(res => res.json())
      .then((data) => {
        if (data.success === true) {
          document.querySelector('#output')
            .innerHTML = `<h2>${data.message}<h2/>
            `;
          setTimeout(() => {
            window.location.replace('user-page.html');
          }, 5000);
        } else {
          let output = '<h3>Error<h3/>';
          Object.keys(data).forEach((key) => {
            output += `<p>${data[key]}<p/>`;
          });
          document.querySelector('#request')
            .innerHTML = output;
        }
      }).catch((error) => {
        document.querySelector('#error')
          .innerHTML = `<h2>server error<h2/>
          <h3>${error}<h3/>`;
      });
  });
}


if (userRequest) {
  userRequest.addEventListener('load', getRequest());
}

