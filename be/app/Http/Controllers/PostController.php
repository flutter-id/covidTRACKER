<?php 

namespace App\Http\Controllers;

use App\Models\Post;
use Ramsey\Uuid\Uuid;
use Illuminate\Http\Request;
use Illuminate\Validation\Rule;
use Illuminate\Support\Facades\Storage;
use Illuminate\Support\Facades\Validator;
use App\Http\Resources\PostCollection;

class PostController extends Controller 
{

  /**
   * Display a listing of the resource.
   *
   * @return Response
   */
  public function index()
  {
    $data = Post::all();
    return new PostCollection(true, 'List of Data',$data);
  }

  public function store(Request $request)
  {
    $validation = Validator::make($request->all(),[
      'category_id' => 
      [                                                                  
        'required',                                                            
        Rule::exists('blog_categories','id', $request->category_id),                                                                    
      ],
      'image'       => 'required|file|image|max:512',
      'title'       => 'required|unique:blog_posts|max:255',
      'slug'        => 'required|unique:blog_posts|max:255',
      'description' => 'required|max:255',
      'summary'     => 'required|max:255',
      'content'     => 'required|max:255',
      'status'      => 'required|in:Draft,Publish',
    ]);
    if($validation->fails()){
      return response()->json($validation->errors(),400);
    }

    $image = $request->file('image');
    $image->storeAs('public/post',$image->hashName());

    $id = Uuid::uuid6();
    $data = [
      'id'          => $id,
      'category_id' => $request->category_id,
      'user_id'     => $request->user()->id,
      'image'       => $image->hashName(),
      'title'       => $request->title,
      'slug'        => $request->slug,
      'description' => $request->description,
      'summary'     => $request->summary,
      'content'     => $request->content,
      'status'      => $request->status,
      'comments'     => 0,
      'featured'    => $request->featured ? 1 : 0

    ];

    Post::create($data);
    return response()->json([
      'success' => true,
      'message' => 'Created Succesfully',
      'data'    => $data
    ],201);
  }

  public function show(Post $post)
  {
    if($post){
      return response()->json([
        'success' => true,
        'message' => 'Show Data',
        'data'    => $post
      ],200);  
    }
    return response()->json([
      'success'   => false,
      'message'   => 'Not Found',
      'data'      => null
    ],404);
  }

  public function edit($id)
  {
    
  }

  /**
   * Update the specified resource in storage.
   *
   * @param  int  $id
   * @return Response
   */
  public function update(Request $request, Post $post)
  {
    $validation = Validator::make($request->all(),[
      'category_id' => 
      [                                                                  
        'required',                                                            
        Rule::exists('blog_categories','id', $request->category_id),                                                                    
      ],
      'image'       => 'required|file|image|max:512',
      'title'       => 'required|max:255|unique:blog_posts,title,'.$post->id,
      'slug'        => 'required|max:255|unique:blog_posts,slug,'.$post->id,
      'description' => 'required|max:255',
      'summary'     => 'required|max:255',
      'content'     => 'required|max:255',
      'status'      => 'required|in:Draft,Publish'
    ]);

    if($validation->fails()){
      return response()->json($validation->errors(),400);
    }

    if(!$post){
      return response()->json([
        'success'   => false,
        'message'   => 'Not Found',
        'data'      => null
      ],404);
    }

    $data = [
      'category_id' => $request->category_id,
      'user_id'     => $request->user()->id,
      'title'       => $request->title,
      'slug'        => $request->slug,
      'description' => $request->description,
      'summary'     => $request->summary,
      'content'     => $request->content,
      'status'      => $request->status,
      'featured'    => $request->featured
    ];

    $image = $request->file('image');
    if($image){
      Storage::disk('local')->delete('public/post/'.basename($post->image));
      $data['image'] = $image->hashName();
    }

    $post->update($data);
    return response()->json([
      'success'     => true,
      'message'     => 'Updated Successfully',
      'data'        => $post
    ],200);
  }

  public function destroy(Post $post)
  {
    if($post){
      Storage::disk('local')->delete('public/post/'.basename($post->image));
      $post->delete();
      return response()->json([
        'success'     => true,
        'message'     => 'Deleted Successfully',
        'data'        => null
      ],200);
    }

    return response()->json([
      'success'       => false,
      'message'       => 'Not Found',
      'data'          => null
    ],404);
  }
}

?>