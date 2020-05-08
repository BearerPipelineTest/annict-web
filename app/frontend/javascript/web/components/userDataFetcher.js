import eventHub from '../../common/eventHub';

import followingRequest from '../requests/followingRequest';
import libraryEntriesRequest from '../requests/libraryEntriesRequest';
import likesRequest from '../requests/likesRequest';

const REQUEST_LIST = {
  'activity-list': [libraryEntriesRequest, likesRequest],
  'edit-record': [libraryEntriesRequest],
  'episode-detail': [libraryEntriesRequest, likesRequest],
  'episode-list': [libraryEntriesRequest],
  'guest-home': [libraryEntriesRequest],
  'library-detail': [libraryEntriesRequest],
  'record-detail': [libraryEntriesRequest, likesRequest],
  'record-list': [libraryEntriesRequest, likesRequest],
  'search-detail': [libraryEntriesRequest],
  'user-home': [libraryEntriesRequest, likesRequest],
  'user-work-tag-detail': [libraryEntriesRequest],
  'work-detail': [libraryEntriesRequest, likesRequest],
  'work-list': [libraryEntriesRequest],
  'work-record-list': [libraryEntriesRequest, likesRequest],
  profile: [followingRequest, libraryEntriesRequest, likesRequest],
};

export default {
  render() {},

  props: {
    pageCategory: {
      type: String,
      required: true,
    },
  },

  mounted() {
    this.fetchAll();

    eventHub.$on('userDataFetcher:refetch', () => {
      this.fetchAll();
    });
  },

  methods: {
    getRequests() {
      return REQUEST_LIST[this.pageCategory] || [];
    },

    fetchAll() {
      Promise.all(this.getRequests().map((req) => req.execute())).then(() => {
        eventHub.$emit('userDataFetcher:fetched');
      });
    },
  },
};
