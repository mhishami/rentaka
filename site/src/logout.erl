%% -*- mode: nitrogen -*-
-module (logout).
-compile(export_all).
-include_lib("nitrogen_core/include/wf.hrl").
-include("records.hrl").

main() -> #template { file="./site/templates/bare.html" }.

title() -> "Rentaka: Logout".

body() ->
    #container_12 { class=rentaka, body=[
        #grid_8 { alpha=true, prefix=2, suffix=2, omega=true, body=common:header() },
        #grid_8 { alpha=true, prefix=2, suffix=2, omega=true, body=inner_body() },
        #grid_8 { alpha=true, prefix=2, suffix=2, omega=true, body=common:footer() }
    ]}.


inner_body() -> 
    [
        #panel { style="margin: 50px 100px;", body=[
            #h2 { text="Confirm Logout" },
            #p{},
            #button { text="Log me out please!", postback=click }
        ]}
    ].
	
event(click) ->
    wf:clear_session(),
    wf:redirect("/"),
    ok.

