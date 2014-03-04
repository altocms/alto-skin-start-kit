{if $sEvent=='add'}
	{include file='header.tpl' menu_content='create'}
{else}
	{include file='header.tpl'}
	<div class="page-header">
		<h1>{$aLang.topic_photoset_edit}</h1>
	</div>
{/if}

{include file='editor.tpl'}

<script type="text/javascript">
    jQuery(function ($) {
        if (jQuery.browser.flash) {
            ls.photoset.initSwfUpload({
                post_params: { 'topic_id': {json var=$_aRequest.topic_id} }
            });
        }
    });
</script>

<div class="modal fade in modal-login" id="window_login_form">
	<div class="modal-dialog">
		<div class="modal-content">

			<form id="photoset-upload-form" method="POST" enctype="multipart/form-data" onsubmit="return false;" class="modal-image-upload">
				<header class="modal-header">
					<button type="button" class="close" data-dismiss="modal" aria-hidden="true">&times;</button>
					<h4 class="modal-title">{$aLang.uploadimg}</h4>
				</header>
	
				<div id="topic-photo-upload-input" class="topic-photo-upload-input modal-body">
					<div class="form-group">
						<label for="photoset-upload-file">{$aLang.topic_photoset_choose_image}</label>
						<input type="file" id="photoset-upload-file" name="Filedata" class="form-control" />
					</div>

					<button type="submit" class="btn btn-success" onclick="ls.photoset.upload();">{$aLang.topic_photoset_upload_choose}</button>
					<button type="submit" class="btn btn-default" onclick="ls.photoset.closeForm();">{$aLang.topic_photoset_upload_close}</button>

					<input type="hidden" name="is_iframe" value="true" />
					<input type="hidden" name="topic_id" value="{$_aRequest.topic_id}" />
				</div>
			</form>

		</div>
	</div>
</div>

{hook run='add_topic_photoset_begin'}

<form action="" method="POST" enctype="multipart/form-data" id="form-topic-add" class="wrapper-content">
	{hook run='form_add_topic_photoset_begin'}

	<input type="hidden" name="security_key" value="{$ALTO_SECURITY_KEY}" />

	<div class="form-group">
		<label for="blog_id">{$aLang.topic_create_blog}</label>
		<select name="blog_id" id="blog_id" onChange="ls.blog.loadInfo(jQuery(this).val());" class="form-control">
			<option value="0">{$aLang.topic_create_blog_personal}</option>
			{foreach $aBlogsAllow as $oBlog}
				<option value="{$oBlog->getId()}" {if $_aRequest.blog_id==$oBlog->getId()}selected{/if}>{$oBlog->getTitle()|escape:'html'}</option>
			{/foreach}
		</select>
		<p class="help-block"><small>{$aLang.topic_create_blog_notice}</small></p>
	</div>

	<script type="text/javascript">
		jQuery(document).ready(function($){
			ls.blog.loadInfo($('#blog_id').val());
		});
	</script>

	<div class="form-group">
		<label for="topic_title">{$aLang.topic_create_title}</label>
		<input type="text" id="topic_title" name="topic_title" value="{$_aRequest.topic_title}" class="form-control" />
		<p class="help-block"><small>{$aLang.topic_create_title_notice}</small></p>
	</div>

	<div class="form-group">
		<label for="topic_text">{$aLang.topic_create_text}</label>
		<textarea name="topic_text" class="mce-editor markitup-editor form-control" id="topic_text" rows="20">{$_aRequest.topic_text}</textarea>
		{if !Config::Get('view.tinymce')}
			{include file='tags_help.tpl' sTagsTargetId="topic_text"}
		{/if}
	</div>
	
	<div class="topic-photo-upload">
		<h4>{$aLang.topic_photoset_upload_title}</h4>

		<div class="small text-muted topic-photo-upload-rules">
			{$aLang.topic_photoset_upload_rules|ls_lang:"SIZE%%`Config::Get('module.topic.photoset.photo_max_size')`":"COUNT%%`Config::Get('module.topic.photoset.count_photos_max')`"}
		</div>

		<input type="hidden" name="topic_main_photo" id="topic_main_photo" value="{$_aRequest.topic_main_photo}" />

		<ul id="swfu_images" class="small list-unstyled">
			{if count($aPhotos)}
				{foreach $aPhotos as $oPhoto}
					{if $_aRequest.topic_main_photo AND $_aRequest.topic_main_photo == $oPhoto->getId()}
						{$bIsMainPhoto=true}
					{/if}

					<li id="photo_{$oPhoto->getId()}" {if $bIsMainPhoto}class="marked-as-preview"{/if}>
						<img src="{$oPhoto->getWebPath('100crop')}" alt="image" />
						<textarea onBlur="ls.photoset.setPreviewDescription({$oPhoto->getId()}, this.value)" class="form-control">{$oPhoto->getDescription()}</textarea>
						<br />
						<a href="javascript:ls.photoset.deletePhoto({$oPhoto->getId()})" class="image-delete">{$aLang.topic_photoset_photo_delete}</a>
						<span id="photo_preview_state_{$oPhoto->getId()}" class="photo-preview-state">
							{if $bIsMainPhoto}
								{$aLang.topic_photoset_is_preview}
							{else}
								<a href="javascript:ls.photoset.setPreview({$oPhoto->getId()})" class="mark-as-preview">{$aLang.topic_photoset_mark_as_preview}</a>
							{/if}
						</span>
					</li>

					{$bIsMainPhoto=false}
				{/foreach}
			{/if}
		</ul>

		<a href="javascript:ls.photoset.showForm()" id="photoset-start-upload">{$aLang.topic_photoset_upload_choose}</a>
	</div>

	<div class="form-group">
		<label for="topic_tags">{$aLang.topic_create_tags}</label>
		<input type="text" id="topic_tags" name="topic_tags" value="{$_aRequest.topic_tags}" class="form-control autocomplete-tags-sep" />
		<p class="help-block"><small>{$aLang.topic_create_tags_notice}</small></p>
	</div>

	<div class="checkbox">
		<label for="topic_forbid_comment">
			<input type="checkbox" id="topic_forbid_comment" name="topic_forbid_comment" value="1" {if $_aRequest.topic_forbid_comment==1}checked{/if} />
			{$aLang.topic_create_forbid_comment}
		</label>
		<p class="help-block"><small>{$aLang.topic_create_forbid_comment_notice}</small></p>
	</div>

	{if E::IsAdmin()}
		<div class="checkbox">
			<label for="topic_publish_index">
				<input type="checkbox" id="topic_publish_index" name="topic_publish_index" value="1" {if $_aRequest.topic_publish_index==1}checked{/if} />
				{$aLang.topic_create_publish_index}
			</label>
			<p class="help-block"><small>{$aLang.topic_create_publish_index_notice}</small></p>
		</div>
	{/if}

	<input type="hidden" name="topic_type" value="photoset" />

	{hook run='form_add_topic_photoset_end'}
	<br />

	<button type="submit" name="submit_topic_publish" id="submit_topic_publish" class="btn btn-success pull-right">{$aLang.topic_create_submit_publish}</button>
	<button type="submit" name="submit_preview" onclick="jQuery('#text_preview').parent().show(); ls.topic.preview('form-topic-add','text_preview'); return false;" class="btn btn-default">{$aLang.topic_create_submit_preview}</button>
	<button type="submit" name="submit_topic_save" id="submit_topic_save" class="btn btn-default">{$aLang.topic_create_submit_save}</button>
</form>

<div class="topic-preview" id="text_preview"></div>

{hook run='add_topic_photoset_end'}

{/block}
