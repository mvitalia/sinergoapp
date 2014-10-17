angular.module('App.service.repository', [])
    .factory('Repository', ['$rootScope', '$http', 'md5',
        function ($rootScope, $http, md5) {
            return {
                data: [],
                status: '',
                method: 'GET',
                url: 'http://pipes.yahoo.com/pipes/pipe.run?_id=581c911b1251acb1f2a6515d2f99f55b&_render=json&feedcount=10&feedurl=http://www.sinergoservizi.com/index.php?option=com_content&amp;view=category&amp;id=43%3Acorsi-in-programma&amp;Itemid=61&amp;layout=default&amp;format=feed&amp;type=rss',

                emptyData: function () {
                    this.data = [];
                },
                fetchData: function() {
                    code = null; 
                    response = null;
                    self = this;
                    $http({method: this.method, url: this.url}).
                    success(function(data, status) {
                        self.status = status;
                        //angular.copy( data.value.items, self.data );
                        parser = document.createElement('a');
                        for (var i = 0; i < data.value.items.length; i++) {
							//var anco= data.value.items[i].description.getElementsByTagName('a') ;
							var link = "'http://www.sinergoservizi.com/images/stories/corsi_di_formazione/vinidea%20modulo.pdf'";
							data.value.items[i].description += '<a href = "javascript:loadURL(' + link + ')">Prova</a>';
							
							/*for (i in anco) {
								 anco[i].href = "javascript:loadURL('" + anco[i].href + "')"; //imposta l'attributo target
							}*/
							
                            self.data.push(data.value.items[i]);
							//alert(data.value.items[i].description);
							
                            parser.href = self.data[i].guid.content;
                            self.data[i].id = md5.createHash( data.value.items[i].title || '') //data.value.items[i].$hashKey;// parser.pathname;
                        }
                    }).
                    error(function(data, status) {
                        self.data = data || "Request failed";
                        self.status = status;
                        //alert("fail");
                    });
                },

                getPost: function(id) {
                    found = false;
                    i = 0;
                    while( found == false && i < this.data.length ) {
                        if (this.data[i].id == id ) {
                            found = this.data[i];
                        }
                        i++;
                    }
                    return found;
                },
                getPostIndex: function(id) {
                    found = false;
                    i = 0;
                    while( found == false && i < this.data.length ) {
                        if (this.data[i].id == id ) {
                            found = i;
                        }
                        i++;
                    }
                    return found;
                },

                getNext: function( id ) {
                    found = false;
                    i = 0;
                    while( found == false && i < this.data.length ) {
                        if (this.data[i].id == id ) {
                            found = i + 1;
                        }
                        i++;
                    }

                    if ( found >= this.data.length ) {
                        found = false
                    } else {
                        found = this.data[found].id;
                    }

                    return found;
                },

                getPrev: function( id ) {
                    found = false;
                    i = 0;
                    while( found == false && i < this.data.length ) {
                        console.log('questo id: '+id);
                        console.log(this.data[i].id);
                        if (this.data[i].id == id ) {
                            found = i - 1;
                        }
                        i++;
                    }

                    if ( found < 0 ) {
                        found = false
                    } else {
                        found = this.data[found].id;
                    }

                    return found;
                }


            }

    }]);
	