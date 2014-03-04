<section class="panel panel-default block block-type-foldable block-type-talk-friends">
	<div class="panel-body">
	
		<header class="block-header">
			<a href="#" class="link-dotted" onclick="jQuery('#block_talk_friends_content').toggle(); return false;">{$aLang.block_friends}</a>
		</header>

		<div class="block-content" id="block_talk_friends_content">
			{if $aUsersFriend}
				<ul id="friends" class="list-unstyled friend-list">
					{foreach $aUsersFriend as $oFriend}
						<li>
							<div class="checkbox">
								<label>
									<input id="talk_friend_{$oFriend->getId()}" type="checkbox" name="friend[{$oFriend->getId()}]" class="input-checkbox" /> 
									<label for="talk_friend_{$oFriend->getId()}" id="talk_friend_{$oFriend->getId()}_label">{$oFriend->getDisplayName()}</label>
								</label>
							</div>
						</li>
					{/foreach}
				</ul>
			
				<footer class="small text-muted">
					<a href="#" id="friend_check_all" class="link-dotted">{$aLang.block_friends_check}</a> | 
					<a href="#" id="friend_uncheck_all" class="link-dotted">{$aLang.block_friends_uncheck}</a>
				</footer>
			{else}
				<div class="notice-empty">{$aLang.block_friends_empty}</div>
			{/if}
		</div>
	
	</div>
</section>
