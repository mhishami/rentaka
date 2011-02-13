%% -*- mode: nitrogen -*-
-module (forgot).
-compile(export_all).
-include_lib("nitrogen_core/include/wf.hrl").
-include("records.hrl").

main() -> #template { file="./site/templates/bare.html" }.

title() -> "Hello from forgot.erl!".

body() ->
    #container_12 { class=rentaka, body=[
        #grid_8 { alpha=true, prefix=2, suffix=2, omega=true, body=common:header() },
        #grid_8 { alpha=true, prefix=2, suffix=2, omega=true, body=inner_body() },
        #grid_8 { alpha=true, prefix=2, suffix=2, omega=true, body=common:footer() }
    ]}.


inner_body() -> 
    Body = [
        #panel { style="margin: 50px 100px;", body=[
            #h2 { text="Forgot your password?" },
            #p{},
            #label { text="Enter email address" },
            #textbox { id=email, next=emailButton },

            #p{},
            #button { id=emailButton, text="Submit", postback=click }
        ]}
    ],
    wf:wire(emailButton, email, #validate { validators = [
        #is_email { text="Email address is invalid!" }
    ]}),
    Body.
	
event(click) ->
    wf:replace(emailButton, #panel { 
        body="email has been sent. Please check your email.",
        actions=#effect { effect=highlight }
    }).


