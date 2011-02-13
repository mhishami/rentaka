%% -*- mode: nitrogen -*-
-module (home).
-compile(export_all).
-include_lib("nitrogen_core/include/wf.hrl").
-include("records.hrl").

main() -> common:main().

title() -> "Rentaka::home!".

body() ->
    #container_12 { class=rentaka, body=[
        #grid_8 { alpha=true, prefix=2, suffix=2, omega=true, body=common:header() },
        #grid_8 { alpha=true, prefix=2, suffix=2, omega=true, body=inner_body() },
        #grid_8 { alpha=true, prefix=2, suffix=2, omega=true, body=common:footer() }
    ]}.

inner_body() -> 
    Body = [
        #panel { style="margin: 50px 100px;", body=[
            #span { text="Hello from home.erl!" },

            #p{},
            #button { text="Click me!", postback=click },

            #p{},
            #panel { id=placeholder }
        ]}
    ],
    Body.
	
event(click) ->
    wf:update(placeholder, "<p>You clicked the button!").

