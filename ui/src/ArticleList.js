import React from 'react';
import { List } from 'semantic-ui-react';
import axios from 'axios';
import Pusher from 'pusher-js';

const pusher = new Pusher('PUSHER_APP_KEY', {
    cluster: 'PUSHER_CLUSTER',
    encrypted: true
});


export class ArticleList extends React.Component {
    state = {
        articles: []
    };

    _showArticle = this._handleShowArticle.bind(this);

    loadList() {
        axios.get('http://localhost/list')
            .then((response) => {
                this.setState({
                    articles: response.data
                });
            });
    }

    _handleShowArticle(article) {
        this.props.showArticle(article.id);
    }

    componentDidMount() {
        this.loadList();

        pusher.subscribe('posts').bind('new-post', () => {
            this.loadList();
        });
    }

    render() {
        const articleEntries = this.state.articles.map((article) => {
            return (
                <List.Item key={article.id} onClick={() => this._showArticle(article)}>
                    <List.Content>
                        <List.Header as='a'>{article.title}</List.Header>
                        <List.Description as='a'>{article.created}</List.Description>
                    </List.Content>
                </List.Item>
            );
        });

        return (
            <List divided relaxed>
                {articleEntries}

                <List.Item onClick={this.props.newArticle}>
                    <List.Content>
                        <List.Header as='a'>New Article</List.Header>
                    </List.Content>
                </List.Item>
            </List>
        );
    }
}
