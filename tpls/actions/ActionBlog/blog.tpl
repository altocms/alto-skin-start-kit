{extends file="_index.tpl"}

{block name="layout_content"}
    {$oUserOwner=$oBlog->getOwner()}
    {$oVote=$oBlog->getVote()}

<script type="text/javascript">
    jQuery(function ($) {
        ls.lang.load({lang_load name="blog_fold_info,blog_expand_info"});
    });
</script>

{if E::IsAdmin()}
    <div class="modal fade in modal-login" id="blog_delete_form">
        <div class="modal-dialog">
            <div class="modal-content">

                <header class="modal-header">
                    <button type="button" class="close" data-dismiss="modal" aria-hidden="true">&times;</button>
                    <h4 class="modal-title">{$aLang.blog_admin_delete_title}</h4>
                </header>

                <div class="modal-body">
                    <form action="{router page='blog'}delete/{$oBlog->getId()}/" method="POST">
                        <div class="form-group">
                            <label for="topic_move_to">{$aLang.blog_admin_delete_move}</label>
                            <select name="topic_move_to" id="topic_move_to" class="form-control">
                                <option value="-1">{$aLang.blog_delete_clear}</option>
                                {if $aBlogs}
                                    <optgroup label="{$aLang.blogs}">
                                        {foreach $aBlogs as $oBlogDelete}
                                            <option value="{$oBlogDelete->getId()}">{$oBlogDelete->getTitle()|escape:'html'}</option>
                                        {/foreach}
                                    </optgroup>
                                {/if}
                            </select>
                        </div>

                        <input type="hidden" name="security_key" value="{$ALTO_SECURITY_KEY}"/>
                        <button type="submit" class="btn btn-success">{$aLang.blog_delete}</button>
                    </form>
                </div>

            </div>
        </div>
    </div>
{/if}


<div class="blog">
    <header class="blog-header">
        <div id="vote_area_blog_{$oBlog->getId()}"
             class="small vote {if $oBlog->getRating() > 0}vote-count-positive{elseif $oBlog->getRating() < 0}vote-count-negative{/if} {if $oVote} voted {if $oVote->getDirection()>0}voted-up{elseif $oVote->getDirection()<0}voted-down{/if}{/if}">
            <div class="text-muted vote-label">Рейтинг</div>
            <a href="#" class="vote-down" onclick="return ls.vote.vote({$oBlog->getId()},this,-1,'blog');"><span
                        class="glyphicon glyphicon-thumbs-down"></span></a>

            <div id="vote_total_blog_{$oBlog->getId()}" class="vote-count count"
                 title="{$aLang.blog_vote_count}: {$oBlog->getCountVote()}">{if $oBlog->getRating() > 0}+{/if}{$oBlog->getRating()}</div>
            <a href="#" class="vote-up" onclick="return ls.vote.vote({$oBlog->getId()},this,1,'blog');"><span
                        class="glyphicon glyphicon-thumbs-up"></span></a>
        </div>

        <img src="{$oBlog->getAvatarPath(64)}" class="avatar"/>

        <h1>{$oBlog->getTitle()|escape:'html'}{if $oBlog->getType()=='close'} <span title="{$aLang.blog_closed}"
                                                                                    class="glyphicon glyphicon-lock"></span>{/if}
        </h1>

        {if E::IsUser() AND (E::UserId()==$oBlog->getOwnerId() OR E::IsAdmin() OR $oBlog->getUserIsAdministrator() )}
            <ul class="small list-unstyled list-inline actions">
                <li>
                    <a href="{router page='blog'}edit/{$oBlog->getId()}/" title="{$aLang.blog_edit}"
                       class="actions-edit">{$aLang.blog_edit}</a></li>
                {if E::IsAdmin()}
                <li><a href="#" title="{$aLang.blog_delete}" id="blog_delete_show"
                       class="actions-delete">{$aLang.blog_delete}</a>
                    {else}
                    <a href="{router page='blog'}delete/{$oBlog->getId()}/?security_key={$ALTO_SECURITY_KEY}"
                       title="{$aLang.blog_delete}" onclick="return confirm('{$aLang.blog_admin_delete_confirm}');"
                       class="actions-delete">{$aLang.blog_delete}</a>
                    {/if}
                </li>
            </ul>
        {/if}
    </header>

    <div class="blog-mini" id="blog-mini">
        <div class="row">
            <div class="col-sm-6 col-lg-6 small text-muted">
                <span id="blog_user_count_{$oBlog->getId()}">{$iCountBlogUsers}</span> {$iCountBlogUsers|declension:$aLang.reader_declension:'russian'}
                ,
                {$oBlog->getCountTopic()} {$oBlog->getCountTopic()|declension:$aLang.topic_declension:'russian'}
            </div>
            <div class="col-sm-6 col-lg-6 blog-mini-header">
                <a href="#" class="small link-dotted"
                   onclick="ls.blog.toggleInfo(); return false;">{$aLang.blog_expand_info}</a>
                <a href="{router page='rss'}blog/{$oBlog->getUrl()}/" class="small">RSS</a>
                {if E::UserId()!=$oBlog->getOwnerId()}
                    <button type="submit" class="btn btn-success btn-sm{if $oBlog->getUserIsJoin()} active{/if}"
                            id="button-blog-join-first-{$oBlog->getId()}"
                            data-button-additional="button-blog-join-second-{$oBlog->getId()}" data-only-text="1"
                            onclick="ls.blog.toggleJoin(this, {$oBlog->getId()}); return false;">{if $oBlog->getUserIsJoin()}{$aLang.blog_leave}{else}{$aLang.blog_join}{/if}</button>
                {/if}
            </div>
        </div>
    </div>

    <div class="blog-more-content" id="blog-more-content" style="display: none;">
        <div class="blog-content">
            <p class="blog-description">{$oBlog->getDescription()}</p>
        </div>

        <footer class="small blog-footer">
            {hook run='blog_info_begin' oBlog=$oBlog}

            <div class="row">
                <div class="col-lg-6">
                    <dl class="dl-horizontal blog-info">
                        <dt>{$aLang.infobox_blog_create}</dt>
                        <dd>{date_format date=$oBlog->getDateAdd() format="j F Y"}</dd>

                        <dt>{$aLang.infobox_blog_topics}</dt>
                        <dd>{$oBlog->getCountTopic()}</dd>

                        <dt><a href="{$oBlog->getUrlFull()}users/">{$aLang.infobox_blog_users}</a></dt>
                        <dd>{$iCountBlogUsers}</dd>

                        <dt>{$aLang.infobox_blog_rating}</dt>
                        <dd class="text-success rating">{$oBlog->getRating()}</dd>
                    </dl>
                </div>

                <div class="col-lg-6">
                    <strong>{$aLang.blog_user_administrators} ({$iCountBlogAdministrators}):</strong><br/>
					<span class="user-avatar">
						<a href="{$oUserOwner->getProfileUrl()}"><img src="{$oUserOwner->getAvatarUrl(24)}"
                                                                      alt="avatar"/></a>
						<a href="{$oUserOwner->getProfileUrl()}">{$oUserOwner->getDisplayName()}</a>
					</span>
                    {if $aBlogAdministrators}
                    {foreach $aBlogAdministrators as $oBlogUser}
                        {$oUser=$oBlogUser->getUser()}
                        <span class="user-avatar">
								<a href="{$oUser->getProfileUrl()}"><img src="{$oUser->getAvatarUrl(24)}" alt="avatar"/></a>
								<a href="{$oUser->getProfileUrl()}">{$oUser->getDisplayName()}</a>
							</span>
                    {/foreach}
                    {/if}<br/><br/>

                    <strong>{$aLang.blog_user_moderators} ({$iCountBlogModerators}):</strong><br/>
                    {if $aBlogModerators}
                        {foreach $aBlogModerators as $oBlogUser}
                            {$oUser=$oBlogUser->getUser()}
                            <span class="user-avatar">
								<a href="{$oUser->getProfileUrl()}"><img src="{$oUser->getAvatarUrl(24)}" alt="avatar"/></a>
								<a href="{$oUser->getProfileUrl()}">{$oUser->getDisplayName()}</a>
							</span>
                        {/foreach}
                    {else}
                        <span class="text-muted">{$aLang.blog_user_moderators_empty}</span>
                    {/if}
                </div>
            </div>

            {hook run='blog_info_end' oBlog=$oBlog}
        </footer>
    </div>
</div>

{hook run='blog_info' oBlog=$oBlog}

<div class="row nav-filter-wrapper">
    <div class="col-lg-12">
        <div class="blog-nav">
            <ul class="nav nav-pills pull-left">
                <li {if $sMenuSubItemSelect=='good'}class="active"{/if}><a href="{$sMenuSubBlogUrl}">{$aLang.blog_menu_collective_good}</a></li>

                <li {if $sMenuSubItemSelect=='new'}class="active"{/if}><a href="{$sMenuSubBlogUrl}newall/">{$aLang.blog_menu_collective_new}{if $iCountTopicsBlogNew>0} +{$iCountTopicsBlogNew}{/if}</a></li>

                <li class="dropdown{if $sMenuSubItemSelect=='discussed'} active{/if}">
                    <a href="{$sMenuSubBlogUrl}discussed/" class="dropdown-toggle" data-toggle="dropdown">
                        {$aLang.blog_menu_collective_discussed}
                        <b class="caret"></b>
                    </a>

                    <ul class="dropdown-menu">
                        <li {if $sMenuSubItemSelect=='discussed' & $sPeriodSelectCurrent=='1'}class="active"{/if}><a
                                    href="{$sMenuSubBlogUrl}discussed/?period=1">{$aLang.blog_menu_top_period_24h}</a>
                        </li>
                        <li {if $sMenuSubItemSelect=='discussed' & $sPeriodSelectCurrent=='7'}class="active"{/if}><a
                                    href="{$sMenuSubBlogUrl}discussed/?period=7">{$aLang.blog_menu_top_period_7d}</a>
                        </li>
                        <li {if $sMenuSubItemSelect=='discussed' & $sPeriodSelectCurrent=='30'}class="active"{/if}><a
                                    href="{$sMenuSubBlogUrl}discussed/?period=30">{$aLang.blog_menu_top_period_30d}</a>
                        </li>
                        <li {if $sMenuSubItemSelect=='discussed' & $sPeriodSelectCurrent=='all'}class="active"{/if}><a
                                    href="{$sMenuSubBlogUrl}discussed/?period=all">{$aLang.blog_menu_top_period_all}</a>
                        </li>
                    </ul>
                </li>

                <li class="dropdown{if $sMenuSubItemSelect=='top'} active{/if}">
                    <a href="{$sMenuSubBlogUrl}top/" class="dropdown-toggle" data-toggle="dropdown">
                        {$aLang.blog_menu_collective_top}
                        <b class="caret"></b>
                    </a>

                    <ul class="dropdown-menu">
                        <li {if $sMenuSubItemSelect=='top' & $sPeriodSelectCurrent=='1'}class="active"{/if}><a
                                    href="{$sMenuSubBlogUrl}top/?period=1">{$aLang.blog_menu_top_period_24h}</a></li>
                        <li {if $sMenuSubItemSelect=='top' & $sPeriodSelectCurrent=='7'}class="active"{/if}><a
                                    href="{$sMenuSubBlogUrl}top/?period=7">{$aLang.blog_menu_top_period_7d}</a></li>
                        <li {if $sMenuSubItemSelect=='top' & $sPeriodSelectCurrent=='30'}class="active"{/if}><a
                                    href="{$sMenuSubBlogUrl}top/?period=30">{$aLang.blog_menu_top_period_30d}</a></li>
                        <li {if $sMenuSubItemSelect=='top' & $sPeriodSelectCurrent=='all'}class="active"{/if}><a
                                    href="{$sMenuSubBlogUrl}top/?period=all">{$aLang.blog_menu_top_period_all}</a></li>
                    </ul>
                </li>

                {hook run='menu_blog_blog_item'}
            </ul>
        </div>
    </div>
</div>

    {if $bCloseBlog}
        <div class="alert alert-danger">
            {$aLang.blog_close_show}
        </div>
    {else}
        {include file='topics/topic.list.tpl'}
    {/if}

{/block}
