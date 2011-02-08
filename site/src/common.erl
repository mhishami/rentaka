%% -*- mode: nitrogen -*-
-module (common).
-compile(export_all).
-include_lib("nitrogen_core/include/wf.hrl").
-include("records.hrl").

main() -> #template { file="./site/templates/bare.html" }.

header() ->
    [
        #p{},
        #panel { class=action, body=[
            #link { url="/signup", text="Sign-Up" }, " | ",
            #link { url="/login", text="Login" }, " | ",
            #link { url="/about", text="About Us" }, " | ",
            #link { url="/help", text="Help" }
        ]}
    ].

footer() ->
    [
        #panel { style="font-size: .7em; font-color: #ddd; text-align: center;", body=[
            "&copy; 2011 ZayMobile Technology. All rights reserved"
        ]}
    ].

