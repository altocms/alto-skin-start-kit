<section class="panel panel-default widget">
    <div class="panel-body">

        <header class="widget-header">
            <h3>{$aLang.block_tags}</h3>
        </header>

        <div class="widget-content">
            {if E::IsUser()}
                <ul class="nav nav-pills">
                    <li class="active js-block-tags-item" data-type="all"><a
                                href="#">{$aLang.topic_favourite_tags_block_all}</a></li>
                    <li class="js-block-tags-item" data-type="user"><a
                                href="#">{$aLang.topic_favourite_tags_block_user}</a></li>

                    {hook run='widget_tags_nav_item'}
                </ul>
            {/if}

            <div class="js-block-tags-content" data-type="all">
                {if $aTags}
                    <ul class="list-unstyled list-inline tag-cloud word-wrap">
                        {foreach $aTags as $oTag}
                            <li><a class="tag-size-{$oTag->getSize()}"
                                   href="{router page='tag'}{$oTag->getText()|escape:'url'}/">{$oTag->getText()|escape:'html'}</a>
                            </li>
                        {/foreach}
                    </ul>
                {else}
                    <div class="notice-empty">{$aLang.block_tags_empty}</div>
                {/if}
            </div>

            {if E::IsUser()}
                <div class="js-block-tags-content" data-type="user" style="display: none;">
                    {if $aTagsUser}
                        <ul class="list-unstyled list-inline tag-cloud word-wrap">
                            {foreach $aTagsUser as $oTag}
                                <li>
                                    <a class="tag-size-{$oTag->getSize()}" href="{router page='tag'}{$oTag->getText()|escape:'url'}/">
                                        {$oTag->getText()|escape:'html'}
                                    </a>
                                </li>
                            {/foreach}
                        </ul>
                    {else}
                        <p class="text-muted">{$aLang.block_tags_empty}</p>
                    {/if}
                </div>
            {/if}
        </div>

    </div>
</section>
