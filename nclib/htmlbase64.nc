class htmlbase64{
    func fileform(id,name,url){
        ret = replace(self.fileform)
    }
    self.fileform = #raw
        <div id="info">Select file to upload and upload..</div>
        <input type="file" id="myfile">Click Me!</input>
        <input type="textfield" id="myfilename">filename</input>
        <button id="myButton">Klik</button>
        <div id="pulsebox"></div>
        <script>
            async function postData(url = '', data = {}) {
                const response = await fetch(url, {
                    method: 'POST', // *GET, POST, PUT, DELETE, etc.
                    mode: 'cors', // no-cors, *cors, same-origin
                    cache: 'no-cache', // *default, no-cache, reload, force-cache, only-if-cached
                    credentials: 'same-origin', // include, *same-origin, omit
                    headers: {
                    'Content-Type': 'multipart/form-data'
                    },
                    redirect: 'follow', // manual, *follow, error
                    referrerPolicy: 'no-referrer', // no-referrer, *no-referrer-when-downgrade, origin, origin-when-cross-origin, same-origin, strict-origin, strict-origin-when-cross-origin, unsafe-url
                    body: JSON.stringify(data) // body data type must match "Content-Type" header
                });
                
                return response.json(); // parses JSON response into native JavaScript objects
            }

            const toBase64 = file => new Promise((resolve, reject) => {
                const reader = new FileReader();
                reader.readAsDataURL(file);
                reader.onload = () => resolve(reader.result);
                reader.onerror = error => reject(error);
            });
            
            document.getElementById('myButton').addEventListener('click', async () => {
                const file = document.querySelector('#myfile').files[0];
                const baseString = await toBase64(file);
                postData('/b64.nc?nakkienekjeweetswa.jpg&', { data: baseString }).then(response => document.getElementById('pulsebox').prepend('Upload Succesfull'));

            });
        </script>
    #endraw
}