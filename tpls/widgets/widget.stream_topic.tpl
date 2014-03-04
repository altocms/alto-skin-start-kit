<ul class="list-unstyled item-list">
    {foreach $aTopics as $oTopic}
        {$oUser=$oTopic->getUser()}
        {$oBlog=$oTopic->getBlog()}
        <li class="text-muted js-title-topic"
            title="{$oTopic->getText()|strip_tags|trim|truncate:150:'...'|escape:'html'}">
            <p class="small">
                <a href="{$oUser->getProfileUrl()}" class="author">{$oUser->getDisplayName()}</a>
                <time datetime="{date_format date=$oTopic->getDate() format='c'}">
                    · {date_format date=$oTopic->getDateAdd() hours_back="12" minutes_back="60" now="60" day="day H:i" format="j F Y, H:i"}
                </time>
            </p>
            <a href="{$oBlog->getUrlFull()}" class="blog-name">{$oBlog->getTitle()|escape:'html'}</a> &rarr;
            <a href="{$oTopic->getUrl()}" class="stream-topic">{$oTopic->getTitle()|escape:'html'}</a>
            <small class="text-danger">{$oTopic->getCountComment()}</small>
        </li>
    {/foreach}
</ul>

<footer class="small text-muted">
    <a href="{router page='index'}newall/">{$aLang.block_stream_topics_all}</a> ·
    <a href="{router page='rss'}new/">RSS</a>
</footer>
