{if E::Topic_IsAllowTopicType($oTopic->getType())}
    {$sTopicTemplateName=$oTopic->getTopicTypeTemplate('content')}
    {include file="topics/$sTopicTemplateName" bTopicList=true}
{/if}
