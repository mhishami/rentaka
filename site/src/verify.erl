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
            #textbox { id=passwd1, next=passwd2 },
            #label { text="Password (again)" },
            #textbox { id=passwd2, next=verifyButton },

            #p{},
            #button { id=verifyButton, text="Click me!", postback=click },

            #p{},
            #panel { id=placeholder }
        ]}],
    wf:wire(verifyButton, #event {
        type=click, actions=#effect { effect=blink }}),
    Body.
	
event(click) ->
    wf:update(placeholder, "<p>You clicked the button!").

