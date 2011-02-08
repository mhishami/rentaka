%% -*- mode: nitrogen -*-
-module (verify).
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
            #h2 { text="Verify Sign-Up" },
            #p{},
            #label { text="Username" },
            #textbox { id=username },
            #label { text="Registration Code" },
            #textbox { id=mobile_no },
            #label { text="Password" },
            #textbox { id=passwd1 },
            #label { text="Password (again)" },
            #textbox { id=passwd2 },

            #p{},
            #button { text="Click me!", postback=click },

            #p{},
            #panel { id=placeholder }
        ]}
    ].
	
event(click) ->
    wf:insert_top(placeholder, "<p>You clicked the button!").
