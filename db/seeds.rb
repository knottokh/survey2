# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)
Tstatusjosb.create({title:"ข้าราชการบำนาญ"})
Tstatusjosb.create({title:"พนักงานราชการ"})
Tstatusjosb.create({title:"ครูอัตราจ้าง"})
Tstatusjosb.create({title:"ครูโครงการพิเศษ"})
Tstatusjosb.create({title:"ปราชญ์ชาวบ้าน"})
Tposition.create({title:"ดนตรีศึกษา"})
Tposition.create({title:"ดนตรีไทย"})
Tposition.create({title:"ดนตรีสากล"})
Tposition.create({title:"ดุริยางคศิลป์"})
Tposition.create({title:"ดุริยางค์ไทย"})
Tposition.create({title:"ดนตรี/นาฏศิลป์"})
Tuniversity.create({title:"จุฬาลงกรณ์มหาวิทยาลัย"})
Tuniversity.create({title:"มหาวทิยาลัยมหิดล"})
Tuniversity.create({title:"มหาวิทยาลัยศิลปากร"})
Tuniversity.create({title:"มหาวิทยาลัยเกษตรศาสตร์"})
Tuniversity.create({title:"มหาวิทยาลัยศรีนครินวิโรฒ ประสานมิตร"})
Tuniversity.create({title:"มหาวิทยาลัยรามคำแหง"})
Tuniversity.create({title:"มหาวิทยาลัยขอนแก่น"})
Tuniversity.create({title:"มหาวิทยาลัยรังสิต"})
Tuniversity.create({title:"มหาวิทยาลัยอัสสัมชัญ"})
Tuniversity.create({title:"มหาวิทยาลัยบูรพา"})
Tuniversity.create({title:"มหาวิทยาลัยเทคโนโลยีราชมงคล"})
Tuniversity.create({title:"มหาวิทยาลัยพายัพ"})
Tuniversity.create({title:"มหาวิทยาลัยมหาสารคาม"})
Tuniversity.create({title:"มหาวิทยาลัยราชภัฏเชียงราย"})
Tuniversity.create({title:"มหาวิทยาลัยราชภัฏจันทรเกษม"})
Tuniversity.create({title:"มหาวิทยาลัยราชภัฏสมเด็จเจ้าพระยา"})
Ttopic.create({title:"ดนตรีไทย"})
Ttopic.create({title:"ดนตรีสากล"})
Ttopic.create({title:"ดุริยางค์"})
Ttopic.create({title:"ดนตรีพื้นบ้าน"})
Tdegree.create({title:"อนุปริญญา"})
Tdegree.create({title:"ปริญญาตรี"})
Tdegree.create({title:"ปริญญาโท"})
Tdegree.create({title:"ปริญญาเอก"})
Musictype.create(title:"ครูดนตรี",formtype:1)
Musictype.create(title:"เครื่องดีด",formtype:2)
Musictype.create(title:"เครื่องสี",formtype:2)
Musictype.create(title:"เครื่องตี",formtype:2)
Musictype.create(title:"เครื่องเป่า",formtype:2)
Musictype.create(title:"เครื่องสาย",formtype:3)
Musictype.create(title:"เครื่องตี",formtype:3)
Musictype.create(title:"เครื่องประเภทลิ่มนิ้ว",formtype:3)
Musictype.create(title:"เครื่องเป่าลมไม้",formtype:3)
Musictype.create(title:"เครื่องเป่าทองเหลือง",formtype:3)
Musictype.create(title:"ภาคเหนือ",formtype:4)
Musictype.create(title:"ภาคอีสาน (เหนือ)",formtype:4)
Musictype.create(title:"ภาคอีสาน (ใต้)",formtype:4)
Musictype.create(title:"ภาคใต้",formtype:4)
User.create(email:"merm.cu@gmail.com",username:"admin",password:"admin11111",role:"admin")