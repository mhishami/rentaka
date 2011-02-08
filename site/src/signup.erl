%% -*- mode: nitrogen -*-
-module (signup).
-compile(export_all).
-include_lib("nitrogen_core/include/wf.hrl").
-include("records.hrl").

main() -> #template { file="./site/templates/bare.html" }.

title() -> "Hello from login.erl!".

body() ->
    #container_12 { class=rentaka, body=[
        #grid_8 { alpha=true, prefix=2, suffix=2, omega=true, body=common:header() },
        #grid_8 { alpha=true, prefix=2, suffix=2, omega=true, body=inner_body() },
        #grid_8 { alpha=true, prefix=2, suffix=2, omega=true, body=common:footer() }
    ]}.


inner_body() -> 
    Body = [
        #panel { style="margin: 50px 100px;", body=[
            #h2 { text="Sign-Up" },
            #p{},
            #label { text="Username" },
            #textbox { id=username },
            #label { text="Mobile Number" },
            #textbox { id=mobile_no },

            #p{},
            #button { id=signUpButton, text="Sign Me Up!", postback=click },

            #p{},
            #panel { id=placeholder }
        ]}
    ],
    wf:wire(signUpButton, username, #validate { validators = [
        #is_required { text="Username is required" }
    ]}),
    wf:wire(signUpButton, mobile_no, #validate { validators = [
        #is_required { text="Password is required" }
    ]}),
    Body.

	
event(click) ->
    wf:insert_top(placeholder, "<p>You clicked the button!").
