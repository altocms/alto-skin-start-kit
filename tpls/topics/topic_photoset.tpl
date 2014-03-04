{include file='topic_part_header.tpl'}

<script type="text/javascript">
	jQuery(window).load(function($) {
		ls.photoset.showMainPhoto({$oTopic->getId()});
	});
</script>

{$oMainPhoto=$oTopic->getPhotosetMainPhoto()}
{if $oMainPhoto}
	<div class="topic-photo-preview" id="photoset-main-preview-{$oTopic->getId()}" onclick="window.location='{$oTopic->getUrl()}#photoset'">
		<div class="topic-photo-count" id="photoset-photo-count-{$oTopic->getId()}"><small>{$oTopic->getPhotosetCount()} {$aLang.topic_photoset_photos}</small></div>

		{if $oMainPhoto->getDescription()}
			<div class="topic-photo-desc" id="photoset-photo-desc-{$oTopic->getId()}"><small>{$oMainPhoto->getDescription()}</small></div>
		{/if}

		<img src="{$oMainPhoto->getWebPath(500)}" alt="image" id="photoset-main-image-{$oTopic->getId()}" />
	</div>
{/if}

{$iPhotosCount=$oTopic->getPhotosetCount()}
<div class="topic-content text">
	{hook run='topic_content_begin' topic=$oTopic bTopicList=$bTopicList}

	{if $bTopicList}
		{$oTopic->getTextShort()}
		{if $oTopic->getTextShort()!=$oTopic->getText()}
			<br />
			<a href="{$oTopic->getUrl()}#cut" title="{$aLang.topic_read_more}" class="read-more">
				{if $oTopic->getCutText()}
					{$oTopic->getCutText()} &rarr;
				{else}
					{$aLang.topic_photoset_show_all|ls_lang:"COUNT%%`$iPhotosCount`"} &rarr;
				{/if}                           
			</a>
		{/if}
	{else}
		{$oTopic->getText()}
	{/if}

	{hook run='topic_content_end' topic=$oTopic bTopicList=$bTopicList}
</div> 

{if !$bTopicList}
	<script type="text/javascript" src="{Config::Get('path.root.engine_lib')}/external/prettyPhoto/js/prettyPhoto.js"></script>
	<link rel='stylesheet' type='text/css' href="{Config::Get('path.root.engine_lib')}/external/prettyPhoto/css/prettyPhoto.css" />
	<script type="text/javascript">
		jQuery(document).ready(function($) {
			$('.photoset-image').prettyPhoto({
				social_tools:'',
				show_title: false,
				slideshow:false,
				deeplinking: false
			});
		});
	</script>

	<div class="topic-photo-images">
		<h2>{$oTopic->getPhotosetCount()} {$oTopic->getPhotosetCount()|declension:$aLang.topic_photoset_count_images}</h2>
		<a name="photoset"></a>
		
		<ul id="topic-photo-images" class="list-unstyled list-inline clearfix">
			{$aPhotos=$oTopic->getPhotosetPhotos(0, Config::Get('module.topic.photoset.per_page'))}
			{if count($aPhotos)}                                
				{foreach $aPhotos as $oPhoto}
					<li><a class="photoset-image" href="{$oPhoto->getWebPath(1000)}" rel="[photoset]"  title="{$oPhoto->getDescription()}"><img src="{$oPhoto->getWebPath('50crop')}" alt="{$oPhoto->getDescription()}" /></a></li>                                    
					{$iLastPhotoId=$oPhoto->getId()}
				{/foreach}
			{/if}
			<script type="text/javascript">
				ls.photoset.idLast='{$iLastPhotoId}';
			</script>
		</ul>

		{if count($aPhotos)<$oTopic->getPhotosetCount()}
			<a href="javascript:ls.photoset.getMore({$oTopic->getId()})" id="topic-photo-more" class="btn btn-info btn-large btn-block topic-photo-more">{$aLang.topic_photoset_show_more} &darr;</a>
		{/if}
	</div>
{/if}
 
{include file='topic_part_footer.tpl'}
