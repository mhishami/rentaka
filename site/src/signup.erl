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
            #flash {},
            #p{},
            #label { text="Username" },
            #textbox { id=username, next=mobile_no },
            #label { text="Mobile Number" },
            #textbox { id=mobile_no, next=signUpButton },

            #p{},
            #button { id=signUpButton, text="Sign Me Up!", postback=signup }
        ]}
    ],
    wf:wire(signUpButton, username, #validate { validators = [
        #is_required { text="Username is required" }
    ]}),
    wf:wire(signUpButton, mobile_no, #validate { validators = [
        #is_required { text="Password is required" }
    ]}),
    wf:wire(signUpButton, mobile_no, #validate { validators = [
        #custom { text="Invalid mobile number. (hint: +60192221212)",
            function=fun validateMobile/2}
    ]}),
    Body.

	
event(signup) ->
    Username = wf:q(username),
    %MobileNo = wf:q(mobile_no),

    % prepare the UI
    Id = wf:temp_id(),

    case zm_auth:get_user(Username) of
        {ok, _}    -> wf:flash(Id, "User already exists. \nPlease use a different username");
        {error, _} -> wf:flash(Id, "New user created!")
    end.

validateMobile(_Tag, Mobile) ->
    case re:run(Mobile, "\\+6[0-9]{10,10}", []) of
        {match,[{0,12}]} -> true;
        _                -> false
    end.

