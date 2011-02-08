-module(nitrogen_init).
-export ([init/0]).
	
%% Called during application startup.
%% Put other initialization code here.
init() ->
    application:start(erlmongo),
    application:start(nprocreg),
    application:start(nitrogen_webmachine).
