angular.module('App.service.repository', [])
    .factory('Repository', ['$rootScope', '$http', 'md5',
        function ($rootScope, $http, md5) {
            return {
                data: [],
                status: '',
                method: 'GET',
                url: 'http://pipes.yahoo.com/pipes/pipe.run?_id=2ef9a510b5d0df22c90cae0395f7b344&_render=json&feedcount=10&feedurl=http://www.sinergoservizi.com/index.php?option=com_content&amp;view=category&amp;id=48%3&amp;Itemid=121&amp;layout=default&amp;format=feed&amp;type=rss',

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
							
							var description = data.value.items[i].description;
							var count_occorency = description.match(/href="/g);  
							
							var start_indice_old = 0;
							if (count_occorency) {
								for (var j = 0 ; j < count_occorency.length; j++){
									var temp_desc = description.substring(start_indice_old, description.length);
									
									var indice = temp_desc.indexOf('href="'); // prima ricorrenza cerco la fine a partire dall'index
									
									// ciclo da inizio href fino a "
									var l = 0;
									
									//s + 6 perche href=" sono 6 caratteri
									indice=indice+6;
									var sub = temp_desc.substring(indice, temp_desc.length);
									
									var res = sub.split("");
									for (var lung = 0 ; lung < sub.length; lung++) {
										if (sub[lung] == '"') {
											l = lung;
											start_indice_old = indice; // memorizzo le ricorrenze precedenti
											break;
										}
									}							
									
									var ancor = temp_desc.substring(indice,(l+indice));
									
									//var stringa_new = "javascript:loadURL('" + ancor + "')";
									var stringa_new = '#" onClick="';
									stringa_new += "window.open('" + ancor + "','_system','location=yes');return false;";
									description = description.replace(ancor,stringa_new);
								}
							}
							//alert(description);
							data.value.items[i].description = description; // aggiorno la nuova descrizione
						
							
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
	