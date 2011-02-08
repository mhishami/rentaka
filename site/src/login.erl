%% -*- mode: nitrogen -*-
-module (login).
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
    [
        #panel { style="margin: 50px 100px;", body=[
            #h2 { text="Login" },
            #p{},
            #label { text="Username" },
            #textbox { id=username },
            #label { text="Password" },
            #password { id=password },

            #p{},
            #button { text="Login", postback=login },
            #button { text="Forgot Password", postback=forgot },

            #p{},
            #panel { id=placeholder }
        ]}
    ].
	
event(login) ->
    wf:insert_top(placeholder, "<p>You clicked the button!").
