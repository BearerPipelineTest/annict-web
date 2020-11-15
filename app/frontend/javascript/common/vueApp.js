import Vue from 'vue';

import channelReceiveButton from './components/channelReceiveButton';
import episodeList from './components/episodeList';
import favoriteButton from './components/favoriteButton';
import followButton from './components/followButton';
import impressionButton from './components/impressionButton';
import impressionButtonModal from './components/impressionButtonModal';
import inputWordsCount from './components/inputWordsCount';
import userActionsDropdown from './components/userActionsDropdown';
import userHeatmap from './components/userHeatmap';
import workComment from './components/workComment';
import workFriends from './components/workFriends';
import workStatusChart from './components/workStatusChart';
import workTags from './components/workTags';
import workWatchersChart from './components/workWatchersChart';
import youtubeModalPlayer from './components/youtubeModalPlayer';

export default {
  start() {
    Vue.component('c-channel-receive-button', channelReceiveButton);
    Vue.component('c-episode-list', episodeList);
    Vue.component('c-favorite-button', favoriteButton);
    Vue.component('c-follow-button', followButton);
    Vue.component('c-impression-button', impressionButton);
    Vue.component('c-impression-button-modal', impressionButtonModal);
    Vue.component('c-input-words-count', inputWordsCount);
    Vue.component('c-user-actions-dropdown', userActionsDropdown);
    Vue.component('c-user-heatmap', userHeatmap);
    Vue.component('c-work-comment', workComment);
    Vue.component('c-work-friends', workFriends);
    Vue.component('c-work-status-chart', workStatusChart);
    Vue.component('c-work-tags', workTags);
    Vue.component('c-work-watchers-chart', workWatchersChart);
    Vue.component('c-youtube-modal-player', youtubeModalPlayer);

    new Vue({
      el: '.ann-application',
    });
  },
};
