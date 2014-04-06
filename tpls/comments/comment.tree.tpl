{wgroup_add group='toolbar' name='toolbar_comment.tpl'
    aPagingCmt=$aPagingCmt
    iTargetId=$iTargetId
    sTargetType=$sTargetType
    iMaxIdComment=$iMaxIdComment
}

{hook run='comment_tree_begin' iTargetId=$iTargetId sTargetType=$sTargetType}

<div class="comments" id="comments">
    <header class="comments-header">
        <span id="count-comments">{$iCountComment}</span> {$iCountComment|declension:$aLang.comment_declension:'russian'}

        {if $bAllowSubscribe AND E::IsUser()}
            <div class="hidden-xs text-muted subscribe form-inline">
                {$aLang.comment_whatch}:
                <div class="checkbox">
                    <label>
                        <input {if $oSubscribeComment AND $oSubscribeComment->getStatus()}checked="checked"{/if}
                               type="checkbox" id="comment_subscribe" class="input-checkbox"
                               onchange="ls.subscribe.toggle('{$sTargetType}_new_comment','{$iTargetId}','',this.checked);">
                        {$aLang.comment_subscribe}
                    </label>
                </div>
            </div>
        {/if}

        <a name="comments"></a>
    </header>

    {$nesting="-1"}
    {foreach $aComments as $oComment}
    {$cmtlevel=$oComment->getLevel()}

    {if $cmtlevel>Config::Get('module.comment.max_tree')}
        {$cmtlevel=Config::Get('module.comment.max_tree')}
    {/if}

    {if $nesting < $cmtlevel}
    {elseif $nesting > $cmtlevel}
    {section name=closelist1  loop=$nesting-$cmtlevel+1}</div>{/section}
    {elseif !$oComment@first}
    </div>
    {/if}

    <div class="comment-wrapper" id="comment_wrapper_id_{$oComment->getId()}">

    {include file='comments/comment.single.tpl'}

    {$nesting=$cmtlevel}
    {if $oComment@last}
        {section name=closelist2 loop=$nesting+1}</div>{/section}
    {/if}
    {/foreach}

{include file='comments/comment.paging.tpl' aPagingCmt=$aPagingCmt}

{hook run='comment_tree_end' iTargetId=$iTargetId sTargetType=$sTargetType}

{if $bAllowNewComment}
    {$sNoticeNotAllow}
{else}
    {if E::IsUser()}
        {include file='commons/common.editor.tpl' sImgToLoad='form_comment_text' sSettingsTinymce='ls.settings.getTinymceComment()' sSettingsMarkitup='ls.settings.getMarkitupComment()'}
        <div class="reply-header" id="comment_id_0">
            <a href="#" class="link-dotted"
               onclick="ls.comments.toggleCommentForm(0); return false;">{$sNoticeCommentAdd}</a>
        </div>
        <div id="reply" class="reply">
            <form method="post" id="form_comment" onsubmit="return false;" enctype="multipart/form-data">
                {hook run='form_add_comment_begin'}

                <textarea name="comment_text" id="form_comment_text"
                          class="mce-editor markitup-editor form-control"></textarea>

                {hook run='form_add_comment_end'}

                <button type="button" onclick="ls.comments.preview();"
                        class="btn btn-default">{$aLang.comment_preview}</button>
                <button type="submit" name="submit_comment"
                        id="comment-button-submit"
                        onclick="ls.comments.add('form_comment',{$iTargetId},'{$sTargetType}'); return false;"
                        class="btn btn-success">{$aLang.comment_add}</button>

                <input type="hidden" name="cmt_target_id" value="{$iTargetId}"/>
                <input type="hidden" name="reply" value="0" id="form_comment_reply"/>
            </form>
        </div>
    {else}
        {$aLang.comment_unregistered}
    {/if}
{/if}
</div>
