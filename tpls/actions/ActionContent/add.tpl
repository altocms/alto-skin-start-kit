{extends file="_index.tpl"}

{block name="layout_vars"}
    {if $sMode=='add'}
        {$menu_content='create'}
    {/if}
{/block}

{block name="layout_content"}

    {include file='modals/modal.upload_photoset.tpl'}
    {include file='editor.tpl'}

    {if $sMode!='add'}
        <div class="page-header">
            <h1>{$aLang.topic_topic_edit}</h1>
        </div>
    {/if}

    {hook run='add_topic_begin'}

    <form action="" method="POST" enctype="multipart/form-data" id="form-topic-add" class="wrapper-content">
        {hook run='form_add_topic_begin'}

        <input type="hidden" name="security_key" value="{$ALTO_SECURITY_KEY}"/>

        <div class="form-group">
            <label for="blog_id">{$aLang.topic_create_blog}</label>
            <select name="blog_id" id="blog_id" onChange="ls.blog.loadInfo(jQuery(this).val());" class="form-control">
                <option value="0">{$aLang.topic_create_blog_personal}</option>
                {foreach $aBlogsAllow as $oBlog}
                    <option value="{$oBlog->getId()}"
                            {if $_aRequest.blog_id==$oBlog->getId()}selected{/if}>{$oBlog->getTitle()|escape:'html'}</option>
                {/foreach}
            </select>

            <p class="help-block">
                <small>{$aLang.topic_create_blog_notice}</small>
            </p>
        </div>

        <script type="text/javascript">
            jQuery(document).ready(function ($) {
                ls.blog.loadInfo($('#blog_id').val());
            });
        </script>

        <div class="form-group">
            <label for="topic_title">{$aLang.topic_create_title}</label>
            <input type="text" id="topic_title" name="topic_title" value="{$_aRequest.topic_title}"
                   class="form-control"/>

            <p class="help-block">
                <small>{$aLang.topic_create_title_notice}</small>
            </p>
        </div>

        {if $sMode != 'add' AND E::IsAdmin()}
        <div class="form-group">
                <label for="topic_url">{$aLang.topic_create_url}:</label>
                <span class="b-topic-url-demo">{$aEditTopicUrl.before}</span><span
                        class="b-topic_url_demo-edit">{$aEditTopicUrl.input}</span>
                {if $_aRequest.topic_url_input AND E::IsAdmin()}
                    <input type="text" id="topic_url" name="topic_url" value="{$_aRequest.topic_url_input}"
                           class="input-text input-width-300" style="display: none;"/>
                {/if}
                <span class="b-topic_url_demo">{$aEditTopicUrl.after}</span>
                {if $sMode != 'add' AND E::IsAdmin()}
                    <button class="button js-tip-help" title="{$aLang.topic_create_url_edit}"
                            onclick="ls.topic.editUrl(this); return false;"><i class="icon-edit"></i></button>
                {/if}
                <button class="button js-tip-help" title="{$aLang.topic_create_url_short}"
                        onclick="ls.topic.shortUrl('{$_aRequest.topic_url_short}'); return false;"><i
                            class="icon-share-alt"></i></button>
                <small class="note"></small>
        </div>
        {/if}

        <div class="form-group">
            <label for="topic_text">{$aLang.topic_create_text}</label>
            <textarea name="topic_text" id="topic_text" rows="20"
                      class="js-editor-wysiwyg js-editor-markitup form-control">{$_aRequest.topic_text}</textarea>

            {if !Config::Get('view.wysiwyg')}
                {include file='fields/field.tags_help.tpl' sTagsTargetId="topic_text"}
            {/if}
        </div>

        {if $oContentType->isAllow('photoset')}
            {include file="fields/field.photoset.edit.tpl"}
        {/if}

        {include file="fields/field.tags.edit.tpl"}

        <div class="checkbox">
            <label>
                <input type="checkbox" id="topic_forbid_comment" name="topic_forbid_comment" value="1"
                       {if $_aRequest.topic_forbid_comment==1}checked{/if} />
                {$aLang.topic_create_forbid_comment}
            </label>

            <p class="help-block">
                <small>{$aLang.topic_create_forbid_comment_notice}</small>
            </p>
        </div>

        {if E::IsAdmin()}
            <div class="checkbox">
                <label>
                    <input type="checkbox" id="topic_publish_index" name="topic_publish_index" value="1"
                           {if $_aRequest.topic_publish_index==1}checked{/if} />
                    {$aLang.topic_create_publish_index}
                </label>

                <p class="help-block">
                    <small>{$aLang.topic_create_publish_index_notice}</small>
                </p>
            </div>
        {/if}

        <input type="hidden" name="topic_type" value="topic"/>

        {hook run='form_add_topic_end'}

        <button type="submit" name="submit_topic_publish" id="submit_topic_publish"
                class="btn btn-success pull-right">{$aLang.topic_create_submit_publish}</button>
        <button type="submit" name="submit_preview"
                onclick="ls.topic.preview('form-topic-add','text_preview'); return false;"
                class="btn btn-default">{$aLang.topic_create_submit_preview}</button>
        <button type="submit" name="submit_topic_save" id="submit_topic_save"
                class="btn btn-default">{$aLang.topic_create_submit_save}</button>
    </form>
    <div class="topic-preview" style="display: none;" id="text_preview"></div>

    {hook run='add_topic_end'}

{/block}
