<?php

// Application middleware

$app->add(function ($request, $response, $next) {

    $responsen = $response->withHeader('Content-Type', 'application/json')
                          ->withHeader('X-Powered-By', $this->settings['PoweredBy']);
	
	
	$APIRateLimit = new App\Utils\APIRateLimiter($this);
	$mustbethrottled = $APIRateLimit();
	
	if ($mustbethrottled == false) {
    $responsen = $next($request, $responsen);
	} else {
        $responsen = $responsen ->withStatus(429)
                                ->withHeader('RateLimit-Limit', $this->settings['api_rate_limiter']['requests']);
	}

    return $responsen;
});

// Define trailing slash middleware
$trailingSlashMiddleware = function (Slim\Http\Request $request, Slim\Http\Response $response, callable $next) {
    $uri = $request->getUri();
    $path = $uri->getPath();

    if ($path != '/' && substr($path, -1) == '/') {
        // redirect paths with a trailing slash
        // to their non-trailing counterpart
        $uri = $uri->withPath(substr($path, 0, -1));

        if ($request->getMethod() == 'GET') {
            return $response->withRedirect((string)$uri, 301);
        } else {
            return $next($request->withUri($uri), $response);
        }
    }

    return $next($request, $response);
};


$app->add($trailingSlashMiddleware);


