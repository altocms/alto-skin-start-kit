<div id="topbanner" role="banner" class="b-header-banner">

    {hook run='header_banner_begin'}

    <div class="container">
        <div class="b-header-banner-inner jumbotron" style="{$aWidgetParams.style}">
            <h1><a href="{Config::Get('path.root.url')}">{$aWidgetParams.title}</a></h1>
        </div>
    </div>

    {hook run='header_banner_end'}

</div>
