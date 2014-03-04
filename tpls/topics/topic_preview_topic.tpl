{$oUser=$oTopic->getUser()}

<div class="page-header">
    <h2>{$aLang.topic_preview}</h2>
</div>

<article class="topic topic-type-{$oTopic->getType()}">
    <header class="topic-header">
        <h1 class="topic-title">
            {$oTopic->getTitle()|escape:'html'}
        </h1>
    </header>

    <div class="topic-content text">
        {hook run='topic_preview_content_begin' topic=$oTopic}

        {$oTopic->getText()}

        {hook run='topic_preview_content_end' topic=$oTopic}
    </div>

    <footer class="topic-footer">
        <ul class="small text-muted list-unstyled list-inline topic-tags">
            <li><span class="glyphicon glyphicon-tags"></span></li>
            {strip}
                {if $oTopic->getTagsArray()}
                    {foreach $oTopic->getTagsArray() as $sTag}
                        <li>{if !$sTag@first},
                            {/if}<a rel="tag" href="{router page='tag'}{$sTag|escape:'url'}/">{$sTag|escape:'html'}</a>
                        </li>
                    {/foreach}
                {else}
                    <li>{$aLang.topic_tags_empty}</li>
                {/if}
            {/strip}
        </ul>

        <ul class="list-unstyled list-inline small topic-info">
            <li class="topic-info-author">
                <a href="{$oUser->getProfileUrl()}"><img src="{$oUser->getAvatarUrl(24)}" alt="avatar" class="avatar"/></a>
                <a rel="author" href="{$oUser->getProfileUrl()}">{$oUser->getDisplayName()}</a>
            </li>
            <li class="topic-info-date">
                <time datetime="{date_format date=$oTopic->getDateAdd() format='c'}" pubdate
                      title="{date_format date=$oTopic->getDateAdd() format='j F Y, H:i'}" class="text-muted">
                    {date_format date=$oTopic->getDateAdd() format="j F Y, H:i"}
                </time>
            </li>

            {hook run='topic_preview_show_info' topic=$oTopic}
        </ul>

        {hook run='topic_preview_show_end' topic=$oTopic}
    </footer>
</article>

<button type="submit" name="submit_topic_publish" class="btn btn-success pull-right" onclick="jQuery('#submit_topic_publish').trigger('click');">{$aLang.topic_create_submit_publish}</button>
<button type="submit" name="submit_preview" onclick="jQuery('#text_preview').html('').hide(); return false;" class="btn btn-default">{$aLang.topic_create_submit_preview_close}</button>
<button type="submit" name="submit_topic_save" class="btn btn-default" onclick="jQuery('#submit_topic_save').trigger('click');">{$aLang.topic_create_submit_save}</button>
