%% -*- mode: nitrogen -*-
-module (verify).
-compile(export_all).
-include_lib("nitrogen_core/include/wf.hrl").
-include("records.hrl").

main() -> #template { file="./site/templates/bare.html" }.

title() -> "Verify Your Mobile".

body() ->
    #container_12 { class=rentaka, body=[
        #grid_8 { alpha=true, prefix=2, suffix=2, omega=true, body=common:header() },
        #grid_8 { alpha=true, prefix=2, suffix=2, omega=true, body=inner_body() },
        #grid_8 { alpha=true, prefix=2, suffix=2, omega=true, body=common:footer() }
    ]}.


inner_body() -> 
    Body = [
        #panel { style="margin: 50px 100px;", body=[
            #h2 { text="Verify Sign-Up" },
            #p{},
            #label { text="Sign-Up Code (from SMS)" },
            #textbox { id=reg_code, next=passwd1 },
            #label { text="Password" },
            #password { id=passwd1, next=passwd2 },
            #label { text="Password (again)" },
            #password { id=passwd2, next=verifyButton },

            #p{},
            #button { id=verifyButton, text="Click me!", postback=click },

            #p{},
            #panel { id=placeholder }
        ]}
    ],
    wf:wire(verifyButton, passwd1, #validate { validators = [
        #is_required { text="Password is required" }
    ]}),
    wf:wire(verifyButton, passwd2, #validate { validators = [
        #confirm_password { text="Password must match.", password=passwd1 }
    ]}),
    Body.
	
event(click) ->
    %% ok, we create the user here
    Username = wf:session(username),
    Password = wf:q(passwd1),

    zm_auth:create_user(Username, Password),
    wf:role(users, true),
    wf:user(Username),
    wf:redirect_from_login("/home").
 

