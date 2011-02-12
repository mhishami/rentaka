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

hex_string(Word) when is_list(Word) ->
    hex_string(crypto:md5(Word));

hex_string(Binary) when is_binary(Binary) ->
    lists:flatten(lists:map(
        fun(X) -> io_lib:format("~2.16.0b", [X]) end, 
        binary_to_list(Binary))).


