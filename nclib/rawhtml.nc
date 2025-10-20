
class rawhtml{
    // holds the raw data to build a form ( is set sepperatly so form spawns dont inherent these properties)
    //functions are in class html
    func load(){
        self.name = "rawhtml"
        self.but = #raw
            <a href="#URL#">
            <button type="button" class="#CLASS#">
            <i class="#ICON#"> </i> #NAME#
            </button>
            </a>

        #endraw
        self.fetch = #raw
            <div id="#ID#result"></div>
            
            <script>
            let #ID#intervalId = null;
            fetch('#URL#')
            .then(response => {
                return response.text();
            })
            .then(data => {
                let #ID#intervalId = null;
                #ID#intervalId = setInterval(() => {
                fetch('#URL#')
                    .then(response => {
                        return response.text();
                    })
                    .then(data => {
                    document.getElementById("#ID#result").innerHTML = data;
                    });
                }, #TIME#); 
            })
            .catch(error => {
                console.error('Error:', error);
                // handle error or display an error message to the user
            });

            // Clear the interval when the page loads (optional)
            window.addEventListener('load', () => {
            clearInterval(#ID#intervalId);
            });
            </script>
        #endraw
        self.updateddiv = #raw
            <div id="#ID#result">#VALUE#</div>
        #endraw
        // <div id="#ID#result">some</div>
        self.updateddivbutton = #raw
           
            <button id="#ID##NAME#refreshButton" class="#CLASS#">
            <i class="#ICON#"> </i>#NAME#</button>
            <script>
                function #ID##NAME#callServer() {
                fetch('#URL#')
                    .then(response => {
                        return response.text();
                    })
                    .then(data => {
                    document.getElementById("#ID#result").innerHTML = data;
                    })
                    .catch(error => console.error('Error:', error));
                }
                // Add event listener for refresh button click
                document.getElementById("#ID##NAME#refreshButton").addEventListener("click", #ID##NAME#callServer);
            </script>
        #endraw
        self.updateddivinputbutton = #raw
            <input id="#ID##NAME#refreshInput" class="#CLASS#">
            <button id="#ID##NAME#refreshButton" class="#CLASS#">
            <i class="#ICON#"> </i>#NAME#</button>
            <script>
                function #ID##NAME#callServer() {
                fetch('#URL#')
                    .then(response => {
                        return response.text();
                    })
                    .then(data => {
                    document.getElementById("#ID#result").innerHTML = data;
                    })
                    .catch(error => console.error('Error:', error));
                }
                // Add event listener for refresh button click
                document.getElementById("#ID##NAME#refreshButton").addEventListener("click", #ID##NAME#callServer);
            </script>
        #endraw
        self.timedclick = #raw
            <a id="myLink" style="display: none;" href="#URL#">#URL#</a>
            <script>
                function simulateClick(linkId, delay) {
                    // Check if the link exists in the document
                    const linkElement = document.getElementById(linkId);
                    if (!linkElement) {
                        console.log(`Link element with ID ${linkId} not found.`);
                        return;
                    }

                    // Add an event listener to wait for the document to finish loading
                    document.addEventListener("DOMContentLoaded", function() {
                        try {
                            // Simulate a click on the link after the delay
                            setTimeout(() => {
                                linkElement.click();
                            }, delay);
                        } catch (error) {
                            console.error(`Error simulating click on link with ID ${linkId}:`, error);
                        }
                    });
                }

                // Example usage: simulate a click on a link after 3 seconds
                simulateClick("myLink", #TIME#);        

            </script>

        #endraw
        self.list = #raw
            <a href="##ID#" data-toggle="collapse" aria-expanded="false" class="dropdown-toggle"><i class="#ICON#" style="color:#COLOR#;"></i> <span>#NAME#</span></a>
            <ul class="collapse list-unstyled" id="#ID#">
                #ITEMS#
            </ul>
        #endraw
        self.listitem = #raw
            <li class="listitemsstyle"><a href="#URL#">➔ <span>#NAME#</span></a></li>
        #endraw
        self.auto = #raw
            <!DOCTYPE html><html><head><title>Auto Click Link</title></head><body>
            <a id="myLink" href="#URL#">Go to Example</a>
            <script>
            document.addEventListener("DOMContentLoaded", function() {
            let link = document.getElementById("myLink");
            if (link) {
                link.click();
            }
            });
            </script></body></html>
        #endraw
        self.barcode = #raw
            <div style="background-color: #FFFFFF; color: #000000; font-family: 'Libre Barcode 39 Text', sans-serif; font-size: 24px;">#TEXT#</div>
        #endraw
        self.login = #raw
            <!DOCTYPE html>
            <html lang="en">
            <head>
                <meta charset="UTF-8">
                <meta name="viewport" content="width=device-width, initial-scale=1.0">
                <title>#TITLE#</title>
                <!-- Bootstrap CSS -->
                <link href="bootstrap.min.css" rel="stylesheet">
                <style>
                    body {
                        background: #2c2e32;
                        min-height: 100vh;
                        display: flex;
                        align-items: center;
                        justify-content: center;
                        padding: 20px;
                    }
                    .login-container {
                        background: #1f2021;
                        padding: 3rem;
                        border-radius: 20px;
                        box-shadow: 0 0 30px rgba(0, 0, 0, 0.5);
                        width: 100%;
                        max-width: 450px;
                        border: 1px solid #34495e;
                    }
                    .login-header {
                        text-align: center;
                        margin-bottom: 2.5rem;
                        color: #ecf0f1;
                    }
                    .login-header h2 {
                        font-size: 2rem;
                        font-weight: 700;
                        text-shadow: 0 2px 4px rgba(0, 0, 0, 0.2);
                    }
                    .login-header .portal-text {
                        font-size: 1.25rem;
                        font-weight: 600;
                        color: #3498db;
                        letter-spacing: 1px;
                        text-shadow: 0 1px 3px rgba(0, 0, 0, 0.3);
                    }
                    .form-control {
                        background: #484b4e;
                        border: none;
                        color: #ecf0f1;
                        padding: 0.75rem;
                    }
                    .form-control:focus {
                        background: #6d6e6f;
                        color: #ecf0f1;
                        border-color: #7c8285;
                        box-shadow: 0 0 0 0.2rem rgba(52, 152, 219, 0.25);
                    }
                    .form-control::placeholder {
                        color: #95a5a6;
                    }
                    .btn-login {
                        background: #495156;
                        border: none;
                        padding: 0.75rem;
                        transition: all 0.3s ease;
                        font-weight: 600;
                    }
                    .btn-login:hover {
                        background: #586f7f;
                        transform: translateY(-2px);
                        box-shadow: 0 4px 15px rgba(52, 152, 219, 0.4);
                    }
                </style>
            </head>
            <body>
                <div class="login-container">
                    <div class="login-header">
                        <h2>#CFG_NAME#</h2>
                        <p class="portal-text">#CFG_INFO#</p>
                        <p class="portal-text">#LOGINMSG#</p>
                    </div>
                    
                    <form id="loginForm" method="POST" action="/index.nc?weblogin&#param3#&#param4#&">
                        <div class="mb-3">
                            <label for="loginId" class="form-label text-light">Login ID</label>
                            <input type="text" class="form-control" id="loginId" name="loginId" placeholder="Enter Login ID" required>
                        </div>
                        <div class="mb-3">
                            <label for="password" class="form-label text-light">Password</label>
                            <input type="password" class="form-control" id="password" name="password" placeholder="Enter Password" required>
                        </div>

                        <button type="submit" class="btn btn-login w-100 mb-3">Login</button>
                    </form>
                </div>
                <script>
                    document.addEventListener('DOMContentLoaded', () => {
                        // Check if loginId is stored and pre-fill it
                        const storedLoginId = localStorage.getItem('loginId');
                        if (storedLoginId) {
                            document.getElementById('loginId').value = storedLoginId;
                            document.getElementById('rememberMe').checked = true;
                        }
                    });

                    function handleLogin(event) {
                        const rememberMe = document.getElementById('rememberMe').checked;

                        if (rememberMe) {
                            const loginId = document.getElementById('loginId').value;
                            localStorage.setItem('loginId', loginId); // Save loginId in localStorage
                        } else {
                            localStorage.removeItem('loginId'); // Remove loginId if "Remember Me" is not checked
                        }
                    }
                </script>
            </body>
            </html>

#endraw
    }
    self.load()
}

class htmlform{
    func load(){
        self.form = #raw
            <style>
            .custom-buttons {
                max-width: #WIDTH#;
                margin: 10px auto;
                display: flex;
                justify-content: space-around;
                gap: 5px;
            }
            .custom-buttons:hover {
                background: #586f7f;
                transform: translateY(-2px);
                box-shadow: 0 4px 15px rgba(37, 65, 84, 0.4);
            }
            .custom-form-container {
                max-width: #WIDTH#;
                margin: 20px auto;
                padding: 20px;
                background-color:rgb(42, 42, 42);
                color: rgb(202, 202, 202);
            border: 1px solidrgb(67, 91, 114);
                border-radius: 10px;
                box-shadow: 0 6px 10px rgba(58, 50, 207, 0.1);
            }
            .form-control {

                background-color:rgb(35, 34, 34);
                color: rgb(202, 202, 202);
                box-shadow: 0 4px 8px rgba(87, 98, 110, 0.1);
                
            }
            .form-control-white {

                background-color:rgba(247, 241, 241, 1);
                color: rgba(8, 8, 8, 1);
                box-shadow: 0 4px 8px rgba(87, 98, 110, 0.1);
                
            }
            .form-control:hover {
                background:rgb(47, 55, 61);
                transform: translateY(-2px);
                box-shadow: 0 4px 15px rgba(52, 152, 219, 0.4);
            }
            .form-control:focus {
                background:rgb(65, 68, 71);
                color: #ecf0f1;
                border-color:rgb(111, 165, 192);
                box-shadow: 0 0 0 0.2rem rgba(83, 179, 242, 0.25);
            }
            .form-control:autofill {
                color:rgb(252, 255, 255);
                background:rgb(65, 68, 71);
            }
            </style>
            <div class="custom-form-container">
            <form method="POST" action="#URL#" enctype="plaintext/html">
            #FORMELEMENTS#
            
            </form>
            </div>
        #endraw
        self.submit = #raw
            <button type="submit" class="btn btn-primary btn-block">#BUTTONNAME#</button>
        #endraw
        //datepicker field
        self.date = #raw
            <div class="form-group">
            <label for="date">Datum:</label>
            <input type="date" class="form-control" id="#IID#" name="#IID#" value="#VALUE#" #REQUIRED# > 
            </div>
        #endraw
        // inputfield
        self.input = #raw
            <div class="form-group">
            <label for="host">#LABEL#</label>
            <input type="text" class="form-control" id="#IID#" name="#IID#" value="#VALUE#" #REQUIRED# >
            </div>
        #endraw
        self.textarea = #raw
            <div class="form-group">
            <label for="host">#LABEL#</label>
            <textarea class="form-control" id="#IID#" name="#IID#" rows="number" cols="number"  #REQUIRED#>#VALUE#</textarea>
            </div>
        #endraw
        // color
        self.color = #raw
            <div class="form-group">
            <label for="host">#LABEL#</label>
            <input type="color" class="form-control" id="#IID#" name="#IID#" value="#VALUE#" #REQUIRED# >
            </div>
        #endraw
        // email
        self.email = #raw
            <div class="form-group">
            <label for="host">#LABEL#</label>
            <input type="email" class="form-control" id="#IID#" name="#IID#" value="#VALUE#" #REQUIRED# >
            </div>
        #endraw
        // filebox
        self.file = #raw
            <div class="form-group">
            <label for="host">#LABEL#</label>
            <input type="file" class="form-control" id="#IID#" name="#IID#" value="#VALUE#" #REQUIRED# >
            </div>
        #endraw
        // combo dropbox 
        self.combo = #raw
            <div class="form-group">
            <label for="status">#TXT#</label>
            <select class="form-control" id="#IID#" name="#IID#" #REQUIRED# >
            #DEFAULT#
            #OPTIONS#
            </select>
            </div>
        #endraw
        // combo option, used in combo
        self.combo_option = #raw
            <option value="#ID#">#ID#</option>
        #endraw
        // pricefield step by 0,05
        self.pricefield = #raw
            <div class="form-group">
            <label for="price">#LABEL#</label>
            <input type="number" class="form-control" id="#IID#" name="#IID#" step="0.05" value="#VALUE#" #REQUIRED# >
            </div>
        #endraw
        // inputfield number
        self.numberfield = #raw
            <div class="form-group">
            <label for="price">#LABEL#</label>
            <input type="number" class="form-control" id="#IID#" name="#IID#" value="#VALUE#" #REQUIRED# >
            </div>
        #endraw
        // password field 
        self.passwordfield = #raw
            <div class="mb-3">
            <label for="password" class="form-label text-light">#LABEL#</label>
            <input type="password" class="form-control" id="#IID#" name="#IID#" placeholder="Enter Password"  #REQUIRED#>
            </div>
        #endraw
        // checkbox html
        self.checkbox = #raw
            <div class="form-check">
            <input type="checkbox" class="form-check-input" id="#IID#" name="#IID#" checked="#VALUE#"  #REQUIRED# >
            <label class="form-check-label" for="checkbox">#LABEL#</label>
            </div>
        #endraw
        self.label = #raw
            <div class="form-group">
            <label for="status">#TXT#</label>
            </div>
        #endraw
    }
    self.load()
}
class icons{
    self.printer = #raw 
        <i class="fa fa-print"> </i>
     #endraw
    self.check = #raw 
        <i class="fa fa-check"> </i>
    #endraw
    self.cross = #raw 
        <i class="fa fa-times"> </i>
    #endraw

}
func icon(name){
    ico = #raw 
        <i class="fa fa-#ID#"> </i>
    #endraw  
    return replace(ico,"#ID#",name)
}