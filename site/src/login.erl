%% -*- mode: nitrogen -*-
-module (login).
-compile(export_all).
-include_lib("nitrogen_core/include/wf.hrl").
-include("records.hrl").

-define(USER, <<"user">>).

main() -> #template { file="./site/templates/bare.html" }.

title() -> "Rentaka :: Login".

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
            #textbox { id=username, next=password },
            #label { text="Password" },
            #password { id=password, next=loginButton },

            #p{},
            #button { id=loginButton, text="Login", postback=login },
            #button { id=forgotButton, text="Forgot Password", postback=forgot },

            #p{},
            #flash{}
        ]}
    ].
	
event(forgot) ->
    wf:redirect("/forgot");

event(login) ->
    Username = wf:q(username),
    Password = wf:q(password),

    case zm_auth:authenticate(Username, Password) of
        {ok, _} ->
            wf:role(users, true),
            wf:user(Username),
            wf:redirect_from_login("/home");
        {error, _} ->
            wf:flash("Invalid username, or password")
    end.


